\name{french.test}
\alias{french.test}
\docType{data}
\title{
French language text fragments
}
\description{
825 fragments from French Wikipedia (the articles on Charlemagne, Descartes, Fourier, Voltaire, Renoir), up to 140 characters each.
}
\usage{data(french.test)}
\format{
  The format is:
 chr [1:825] "Le lieu de la naissance de Charlemagne n'est mentionn\303\251 dans aucune source d'\303\251poque. La plus ancienne indication, "| __truncated__ ...
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
data(french.test)
sample(french.test, 1)
}
\keyword{datasets}
