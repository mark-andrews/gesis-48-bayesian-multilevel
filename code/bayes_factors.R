log_evidence <- function(m, n, alpha, beta) lbeta(m + alpha, n-m + beta) - lbeta(alpha, beta)
log_evidence_null <- function(n) -n *log(2)

log_bayes_factor <- function(m, n, alpha=1.0, beta=1.0) {
  log_evidence(m, n, alpha, beta) - log_evidence_null(n)
}

bayes_factor <- function(m, n, alpha=1.0, beta=1.0){
  exp(log_bayes_factor(m, n, alpha, beta))
}