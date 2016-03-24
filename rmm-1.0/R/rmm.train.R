rmm.train <-
function(dat, nstates, nvalues, nmodels=100){

  T = length(dat)
  # set model hashes:
  hash = array(
    dim=c(nstates, nvalues, nmodels),
    data=sample(nstates, nstates*nvalues*nmodels, replace=T)
    )
  # initialise the emission matrix for each model:
  emission = array(
    dim=c(nstates, nvalues, nmodels),
    data=0
    )

  # pass these variables and the function arguments to the C function:
  out = .C("rmm_train", PACKAGE="rmm",
    # input:
    T = as.integer(T),
    nstates = as.integer(nstates),
    nvalues = as.integer(nvalues),
    nmodels = as.integer(nmodels),
    dat = as.integer(dat-1),
    hash = as.integer(hash-1),
    # output:
    emission = as.double(emission)
    )
  emission = out$emission
  dim(emission) = c(nstates, nvalues, nmodels)
  list(hash=hash, emission=emission)
}
