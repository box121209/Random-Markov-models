\name{rmm.train}
\alias{rmm.train}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Train an RMM on a categorical sequence
}
\description{
Trains an ensemble of models as described below. Outputs the random hash used for each model in the ensemble, together with a probability distribution over the value set for each state. 
}
\usage{
rmm.train(dat, nstates, nvalues, nmodels = 100)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dat}{
An integer sequence.
}
  \item{nstates}{
Number of hidden states to use.
}
  \item{nvalues}{
Number of values emitted. \code{dat} is assumed to have values in {1,...,\code{nvalues}}.
}
  \item{nmodels}{
Number of models in the ensemble.
}
}
\details{
Trains each model in an ensemble as follows. First assign a random map V x S --> S (S = hidden states, V = observed values). Collectively this is represented by a random S-valued |S| x |V| x N array 'hash' (where N = ensemble size). Then (for each model in the ensemble) use hash and the observed V-sequence to generate an S-sequence (randomly initialised). Over the whole ensemble, generate a table of counts over S x V; and finally row normalise to a Markov matrix 'emission' of (empirical) probability distributions over V, one for each state in S. 
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
 \item{hash}{S-valued 3-index array, indexed by S,V and the ensemble}
  \item{emission}{S x V Markov matrix of emission probabilities}
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
\code{\link{rmm.test}}
}
\examples{
tr <- rmm.train(text.convert(english.train), 10, 27)
str(tr)
( m <- tr$emission[,,sample(100,1)] )
rowSums(m)
dim(tr$hash)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
