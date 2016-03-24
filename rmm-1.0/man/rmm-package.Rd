\name{rmm-package}
\alias{rmm-package}
\alias{rmm}
\docType{package}
\title{
Random Markov Models
}
\description{
Implementation of Barry Chen's RMM approach to scoring categorical sequences against a training sequence. Cheaper to train than HMMs, and counter-intuitively efective. An RMM is a randomised data summary rather than a true statistical model. 
}
\details{
\tabular{ll}{
Package: \tab rmm\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2013-05-27\cr
License: \tab UKG\cr
}
There are just two main functions: \code{\link{rmm.train}} and \code{\link{rmm.test}}. The input to both is an integer sequence (plus some other arguments), so the package also contains a utility \code{\link{text.convert}} used in the text examples. See the examples below.
}
\author{
Bill Oxbury

Maintainer: Bill Oxbury <wmoxbur@gchq>
}
\references{
Barry Chen, SANAR 2012}
\keyword{ package }
\seealso{
}
\examples{
# for all of the following examples:
fragment <- c(english.test, french.test, german.test)
where <- c(
  rep(1,length(english.test)), 
  rep(2,length(french.test)), 
  rep(3,length(german.test)))

# example 1:
# distinguishing single-language text

nm <- 100  # nr models
ns <- 10   # nr states
nvalues <- 27
rmm <- rmm.train(text.convert(french.train), ns, nvalues, nmodels=nm)
h <- rmm$hash
em <- rmm$emission
score <- c()
for(f in fragment){
    tmp <- text.convert(f)
    score <- c(score, rmm.test(tmp, h, em)$score / length(tmp))
}

plot(density(score[where==1]), col=1, type='l',
       xlim=c(min(score)-0.05,max(score)+0.05),
       ylim=c(0,8),
       xlab="French log-likelihood", main="French model")
points(density(score[where==2]), col=2, type='l')
points(density(score[where==3]), col=3, type='l')
legend("topleft", legend=c("English","French","German"), col=1:3, lwd=1, bty='n')

# example 2:
# train on two languages

rmm1 <- rmm.train(text.convert(english.train), ns, nvalues, nmodels=nm)
h1 <- rmm1$hash
em1 <- rmm1$emission

rmm2 <- rmm.train(text.convert(german.train), ns, nvalues, nmodels=nm)
h2 <- rmm2$hash
em2 <- rmm2$emission
  
# ... and test
score <- array( dim=c(length(fragment),2) )
for( i in 1:length(fragment) ){ 
    tmp <- text.convert(fragment[i])
    s1 <- rmm.test(tmp, h1, em1)$score / length(tmp)
    s2 <- rmm.test(tmp, h2, em2)$score / length(tmp)
    score[i,] <- c(s1,s2)
}
plot(score[where!=2,], pch=1, cex=1, col=where[where!=2],
      xlab="English", ylab="German", main="2D English-German model")
legend("bottomright", legend=c("English","German"), pch=19, col=c(1,3), bty="n")

# examine outliers:
index <- 1:length(fragment)
fragment[ index[ score[,1] > -2.0 ] ]
fragment[ index[ score[,2] < -3.5 ] ]
fragment[ index[ score[,1] < -3.2 & where==3 ] ]

# example 3:
# train on all three languages and apply LDA to find best projection:

# train:
rmm1 <- rmm.train(text.convert(english.train), ns, nvalues, nmodels=nm)
h1 <- rmm1$hash; em1 = rmm1$emission
rmm2 <- rmm.train(text.convert(french.train), ns, nvalues, nmodels=nm)
h2 <- rmm2$hash; em2 = rmm2$emission
rmm3 <- rmm.train(text.convert(german.train), ns, nvalues, nmodels=nm)
h3 <- rmm3$hash; em3 = rmm3$emission

# test:
score <- array( dim=c(length(fragment),3) )
for(i in 1:length(fragment)){ 
  tmp <- text.convert(fragment[i])
  s1 <- rmm.test(tmp, h1, em1)$score / length(tmp)
  s2 <- rmm.test(tmp, h2, em2)$score / length(tmp)
  s3 <- rmm.test(tmp, h3, em3)$score / length(tmp)
  score[i,] <- c(s1,s2,s3)
}

lang <- data.frame(cbind(score, where))

library(MASS)
lang.lda <- lda(where ~ ., lang)
lang.lda.pred <- predict(lang.lda)

eqscplot(lang.lda.pred$x,
         pch=1, cex=0.5, 
         col = where,
         xlim=c(-6,6), ylim=c(-7,6),
         xlab="LD1", ylab="LD2", main="LDA projection of 3D model")
legend("topleft", legend=c("English","French","German"), col=1:3, bty='n', pch=19)

# example 4:
# try classifying untrained languages...

fragment.new <- c(dutch.test, italian.test)
where.new <- c(rep("blue", length(dutch.test)), rep("orange", length(italian.test)))

score <- array( dim=c(length(fragment.new),3) )
for(i in 1:length(fragment.new)){ 
  tmp <- text.convert(fragment.new[i])
  s1 <- rmm.test(tmp, h1, em1)$score / length(tmp)
  s2 <- rmm.test(tmp, h2, em2)$score / length(tmp)
  s3 <- rmm.test(tmp, h3, em3)$score / length(tmp)
  score[i,] <- c(s1,s2,s3)
}

plot(score[,2:3], pch=1, cex=0.5, col=where.new,
       xlab="French", ylab="German", main="Testing unknown languages in the 2D model")
legend("bottomright", legend=c("Dutch","Italian"), col=c("blue","orange"), bty='n', pch=19)
}
