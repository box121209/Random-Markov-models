text.convert <-
function(str){
  len <- nchar(str, type="bytes")
  cnt <- 0
  num <- integer(len)
  out <- .C("text_convert", PACKAGE="rmm",
          # input:
          str = as.character(str),
          len = as.integer(len),
          # output:
          num = as.integer(num),
          cnt = as.integer(cnt)
  )$num
  out[out>0]
}
