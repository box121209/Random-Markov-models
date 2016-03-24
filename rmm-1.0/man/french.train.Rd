\name{french.train}
\alias{french.train}
\docType{data}
\title{
French language training text
}
\description{
72526-character string from French language Wikipedia (the articles on Bordeau and de Gaulle).
}
\usage{data(french.train)}
\format{
  The format is:
 chr "Bordeaux est situ\303\251e pr\303\250s de la c\303\264te Atlantique, dans le Sud-Ouest de la France. \303\200 vol d'oiseau, ell"| __truncated__
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
data(french.train)
table(strsplit(french.train, ""))
}
\keyword{datasets}
