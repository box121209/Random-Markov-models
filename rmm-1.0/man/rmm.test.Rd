\name{rmm.test}
\alias{rmm.test}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Score a sequence against an RMM 
}
\description{
Given a model (ensemble) and a new sequence, scores the latter, outputting a sequence of termwise probabilities and a global log likelihood score.
}
\usage{
rmm.test(dat, hash, emission)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dat}{
Integer sequence.
}
  \item{hash}{
S-valued 3-index array, indexed by S,V and the ensemble
}
  \item{emission}{
S x V Markov matrix of emission probabilities
}
}
\details{
The secodn and third arguments are the output of the training function \code{\link{rmm.train}}.
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
\item{post}{Termwise mean probability sequence under the ensemble.}
\item{score}{Log likelihood, i.e. sum of the logs of \code{post}.}
%% ...
}
\references{
}
\author{
Bill Oxbury
}
\note{
}

\seealso{
\code{\link{rmm.train}}
}
\examples{
tr <- rmm.train(text.convert(english.train), 10, 27)
rmm.test(text.convert("hello world"), tr$hash, tr$emission)$score
rmm.test(text.convert("bonjour le monde"), tr$hash, tr$emission)$score

tr <- rmm.train(text.convert(french.train), 10, 27)
rmm.test(text.convert("oh shit!"), tr$hash, tr$emission)$score
rmm.test(text.convert("merde!"), tr$hash, tr$emission)$score
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ }
\keyword{ }% __ONLY ONE__ keyword per line
