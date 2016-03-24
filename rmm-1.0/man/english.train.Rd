\name{english.train}
\alias{english.train}
\docType{data}
\title{
English language training text
}
\description{
45189-character string from English language Wikipedia (the articles on Oxford and Darwin).
}
\usage{data(english.train)}
\format{
  The format is:
 chr "Charles Robert Darwin was born in Shrewsbury, Shropshire, England on 12 February 1809 at his family home, The Mount,[18] He was"| __truncated__
}
\details{
%%  ~~ If necessary, more details than the __description__ above ~~
}
\source{
%%  ~~ reference to a publication or URL from which the data were obtained ~~
}
\references{
%%  ~~ possibly secondary sources and usages ~~
}
\examples{
data(english.train)
table(strsplit(english.train, ""))
}
\keyword{datasets}
