rmm.test <-
function(dat, hash, emission){

  T = length(dat)
  nstates = dim(hash)[1]
  nvalues = dim(hash)[2]
  nmodels = dim(hash)[3]

  # pass these variables and the function arguments to the C function:
  out = .C("rmm_test", PACKAGE="rmm",
    # input:
    T = as.integer(T),
    nstates = as.integer(nstates),
    nvalues = as.integer(nvalues),
    nmodels = as.integer(nmodels),
    dat = as.integer(dat-1),
    hash = as.integer(hash-1),
    emission = as.double(emission),
    # output:
    post = as.double(rep(0.0,T)),
    score = as.double(1)
    )
  list(post=out$post, score=out$score)
}
