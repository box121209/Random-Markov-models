\name{text.convert}
\alias{text.convert}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Convert string to integer sequence
}
\description{
Converts alphabetic characters (upper or lower case) to number 1-26, and space character to 27. Ignores all other characters.
}
\usage{
text.convert(str)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{str}{
Character string
}
}
\details{
Implemented in the file src/rmm.c. Feel free to improve the code to convert non-alphabetic characters etc.
}
\value{
Integer array (currently numbers 1-27 only)
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Bill Oxbury
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
text.convert("hello, world!")
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (str) 
{
    len <- nchar(str, type = "bytes")
    cnt <- 0
    num <- integer(len)
    out <- .C("text_convert", PACKAGE = "rmm", str = as.character(str), 
        len = as.integer(len), num = as.integer(num), cnt = as.integer(cnt))$num
    out[out > 0]
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
