## after-wrappers.R
## THIS FILE IS SOURCED IMMEDIATELY AFTER extendr-wrappers.R . THIS FILE EXTENDS THE BEHAVIOUR
## OF EXTENDR-CLASS-SYSTEM WITH:
## 1. SEPARATE PRIVATE (.pr$) AND PUBLIC (pl$) METHODS/FUNCTIONS
## 2. ADD INTERNAL PROFILER, pl$set_polars_options(debug_polars = TRUE)
## 3. ADD build_debug_print TO DEBUG CLASS CONSTRUCTION DURING PACKAGE BUILDTIME (rarely used)
## 4. ADD BETTER METHOD LOOKUP ERR MSGS macro_add_syntax_check_to_class(), HELPS END USER
## 5. ADD OPTION TO FLAG A METHOD TO BEHAVE LIKE A PROPERTY method_as_property()


# Build time options
build_debug_print = FALSE

#' extendr methods into pure functions
#' @noRd
#' @param env environment object output from extendr-wrappers.R classes
#' @param class_name optional class string, only used for debug printing
#' Default NULL, will infer class_name automatically
#' @keywords internal
#' @description self is a global of extendr wrapper methods
#' this function copies the function into a new environment and
#' modify formals to have a self argument
#'
#' @return env of pure function calls to rust
#'
extendr_method_to_pure_functions = function(env, class_name = NULL) {
  if (is.null(class_name)) class_name <- as.character(sys.call()[2])
  e = as.environment(lapply(env, function(f) {
    if (!is.function(f)) {
      return(f)
    }
    if ("self" %in% codetools::findGlobals(f)) {
      formals(f) = c(alist(self = ), formals(f))
    }
    f
  }))
  class(e) = c("private_polars_env", paste0("pr_", class_name), "environment")
  e
}


#' get private method from Class
#' @details This method if polars_optenv$debug_polars == TRUE will print what methods are called
#' @noRd
#' @export
#' @keywords internal
"$.private_polars_env" = function(self, name) {
  # print called private class in debug mode
  if (polars_optenv$debug_polars) {
    cat(
      "[", format(subtimer_ms("TIME? "), digits = 4), "ms]\n   .pr$",
      substr(class(self)[2], 4, 99), "$", name, "() -> ",
      sep = ""
    )
  }
  self[[name]]
}


#' @include extendr-wrappers.R
#' @title polars-API: private calls to rust-polars
#' @description `.pr`
#' Original extendr bindings converted into pure functions
#' @details
#' .pr gives access to all private methods of package polars. Use at own discretion.
#' The polars package may introduce breaking changes to any private method in a patch with no
#' deprecation warning. Most private methods takes `self` as a first argument, the object the
#' method should be called upon.
#' @aliases  .pr
#' @keywords internal api_private
#' @return not applicable
#' @export
#' @examples
#' # .pr$DataFrame$print() is an external function where self is passed as arg
#' .pr$DataFrame$print(self = pl$DataFrame(iris))
#'
#' # show all content of .pr
#' .pr$print_env(.pr, ".pr the collection of private method calls to rust-polars")
.pr = new.env(parent = emptyenv())
.pr$Series = extendr_method_to_pure_functions(Series)
.pr$DataFrame = extendr_method_to_pure_functions(DataFrame)
.pr$GroupBy = NULL # derived from DataFrame in R, has no rust calls
.pr$LazyFrame = extendr_method_to_pure_functions(LazyFrame)
.pr$LazyGroupBy = extendr_method_to_pure_functions(LazyGroupBy)
.pr$PolarsBackgroundHandle = extendr_method_to_pure_functions(PolarsBackgroundHandle)
.pr$DataType = extendr_method_to_pure_functions(RPolarsDataType)
.pr$DataTypeVector = extendr_method_to_pure_functions(DataTypeVector)
.pr$RField = extendr_method_to_pure_functions(RField)
.pr$Expr = extendr_method_to_pure_functions(Expr)
.pr$ProtoExprArray = extendr_method_to_pure_functions(ProtoExprArray)
.pr$When = extendr_method_to_pure_functions(When)
.pr$WhenThen = extendr_method_to_pure_functions(WhenThen)
.pr$WhenThenThen = extendr_method_to_pure_functions(WhenThenThen)
.pr$VecDataFrame = extendr_method_to_pure_functions(VecDataFrame)
.pr$RNullValues = extendr_method_to_pure_functions(RNullValues)
.pr$RPolarsErr = extendr_method_to_pure_functions(RPolarsErr)



# add package environment to .pr, this can be used as replacement for :::, where cran does not
# allow that. Ok use :
#  - internal documentation (noRd) to show case inner workings of code.
#  - unit tests, which needs to verify an internal state.
.pr$env = getNamespace("polars")
.pr$print_env = print_env



##### -----  MACROS used at package build time

#' @title add syntax verification to a class
#' @include utils.R
#' @param Class_name string name of env class
#' @rdname macro_add_syntax_check_to
#' @noRd
#' @keywords internal
#' @return dollarsign method with syntax verification
#'
#' @details this function overrides dollarclass method of a extendr env_class
#' to run first verify_method_call() to check for syntax error and return
#' more user friendly error if issues
#'
#' All R functions coined 'macro'-functions use eval(parse()) but only at package build time
#' to solve some tricky self-referential problem. If possible to deprecate a macro in a clean way
#' , go ahead.
#'
#' see zzz.R for usage examples
#'
#' @seealso verify_method_call
macro_add_syntax_check_to_class = function(Class_name) {
  tokens = paste0(
    "`$.", Class_name, "` <- function (self, name) {\n",
    "  verify_method_call(", Class_name, ",name)\n",
    "  func <- ", Class_name, "[[name]]\n",
    "  environment(func) <- environment()\n",
    "  if(inherits(func,'property')) {\n",
    "    func()\n",
    "  } else {\n",
    "   func\n",
    "  }\n",
    "}"
  )

  eval(parse(text = tokens), envir = parent.frame())
}


## modify classes to perform syntax checking
## this relies on no envrionment other than env_classes has been defined when macro called
## this mod should be run immediately after extendr-wrappers.R are sourced
is_env_class = sapply(mget(ls()), \(x) typeof(x) == "environment")
env_class_names = names(is_env_class)[is_env_class]
if (build_debug_print) cat("\nadd syntax check to: ")
for (i_class in env_class_names) {
  if (build_debug_print) cat(i_class, ", ", sep = "")
  if (!exists(paste0("$.", i_class))) {
    stopf("internal assertion failed, env class without a dollarsign method")
  }
  macro_add_syntax_check_to_class(i_class)
}
if (build_debug_print) cat("\n")


#' Give a class method property behavior
#' @description Internal function, see use in source
#' @noRd
#' @param f a function
#' @param setter bool, if true a property method can be modified by user
#' @keywords internal
#' @return function subclassed into c("property","function") or c("setter","property","function")
method_as_property = function(f, setter = FALSE) {
  class(f) = if (setter) {
    c("setter", "property", "function")
  } else {
    c("property", "function")
  }
  f
}


#' @title The complete polars public API.
#' @description `pl`-object is a environment of all public functions and class constructors.
#' Public functions are not exported as a normal package as it would be huge namespace
#' collision with base:: and other functions. All object-methods are accessed with object$method()
#' via the new class functions.
#'
#' Having all functions in an namespace is similar to the rust- and python- polars api.
#' @name pl_pl
#' @aliases pl
#' @keywords api
#' @details If someone do not particularly like the letter combination `pl`, they are free to
#' bind the environment to another variable name as `simon_says = pl` or even do `attach(pl)`
#' @return not applicable
#' @export
#' @examples
#' # how to use polars via `pl`
#' pl$col("colname")$sum() / pl$lit(42L) # expression ~ chain-method / literal-expression
#'
#' # show all public functions, RPolarsDataTypes, classes and methods
#' pl$show_all_public_functions()
#' pl$show_all_public_methods()
pl = new.env(parent = emptyenv())
class(pl) = c("pl_polars_env", "environment")


#' show all public functions / objects
#' @name show_all_public_functions
#' @description print any object(function, RPolarsDataType) available via `pl$`.
#' @return NULL
#' @keywords functions
#' @examples
#' pl$show_all_public_functions()
pl$show_all_public_functions = function() {
  print_env(pl, "polars public functions via pl$...")
}

#' show all public methods
#' @name show_all_public_methods
#' @description methods are listed by their Class
#' @param class_names character vector of polars class names to show, Default NULL is all.
#' @return NULL
#' @keywords functions
#' @examples
#' pl$show_all_public_methods()
pl$show_all_public_methods = function(class_names = NULL) {

  #subset classes to show
  show_this_env = if(!is.null(class_names)) {
    as.environment(mget(class_names, envir = pl_pub_class_env))
  } else {
    pl_pub_class_env
  }

  print_env(
    show_this_env,
    paste(
      paste(class_names, collapse = ", "),
      "class methods, access via object$method()"
    )
  )
}

#' get public function from pl namespace/env
#' @details This method if polars_optenv$debug_polars == TRUE will print what methods are called
#' @return an element from the public namespace `pl` polars. Likely a function or an RPolarsDataType
#' @export
#' @noRd
#' @keywords internal
"$.pl_polars_env" = function(self, name) {
  # print called private class in debug mode
  if (polars_optenv$debug_polars) {
    cat(
      "[", format(subtimer_ms("TIME? "), digits = 4), "ms]\npl$", name, "() -> ",
      sep = ""
    )
  }
  self[[name]]
}



# remap
DataType = clone_env_one_level_deep(RPolarsDataType)

# used for printing public environment
pl_class_names = sort(
  c(
    "LazyFrame", "Series", "LazyGroupBy", "DataType", "Expr", "DataFrame", "PolarsBackgroundHandle",
    "When", "WhenThen", "WhenThenThen"
  )
) # TODO discover all public class automatically

pl_pub_env = as.environment(asNamespace("polars"))
pl_pub_class_env = as.environment(mget(pl_class_names, envir = pl_pub_env))


#' @title Any polars class object is made of this
#' @name polars_class_object
#' @description One SEXP of Rtype: "externalptr" + a class attribute
#' @keywords api_object
#' @details
#'  - `object$method()` calls are facilitated by a `$.ClassName`- s3method see 'R/after-wrappers.R'
#'  - Code completion is facilitated by `.DollarNames.ClassName`-s3method see e.g. 'R/dataframe__frame.R'
#'  - Implementation of property-methods as DataFrame_columns() and syntax checking is an extension to `$.ClassName`
#'  See function macro_add_syntax_check_to_class().
#'
#' @importFrom utils .DollarNames
#' @return not applicable
#' @examples
#' # all a polars object is only made of:
#' some_polars_object = pl$DataFrame(iris)
#' str(some_polars_object) # External Pointer tagged with a class attribute.
#'
#' # All state is stored on rust side.
#'
#' # The single exception from the rule is class "GroupBy", where objects also have
#' # two private attributes "groupby_input" and "maintain_order".
#' str(pl$DataFrame(iris)$groupby("Species"))
NULL
