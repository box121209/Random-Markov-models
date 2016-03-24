\name{german.train}
\alias{german.train}
\docType{data}
\title{
German language training text
}
\description{
60834-character string from German language Wikipedia (the articles on Bonn and Herbert von Karajan).
}
\usage{data(german.train)}
\format{
  The format is:
 chr "Am \303\234bergang vom Rheinischen Schiefergebirge zur Niederrheinischen Tiefebene liegt im S\303\274dwesten des Bundeslandes N"| __truncated__
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
data(german.train)
table(strsplit(german.train, ""))
}
\keyword{datasets}
