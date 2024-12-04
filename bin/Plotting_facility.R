plot_results <- function(package_name) {
	filename <- paste("results/results_", toupper(package_name), ".pdf",
	                  sep = "")
	pdf(filename)
	par(mfrow = c(1, 3))
	plot(sc_scores_good, main = "Sanity check (good)",
		xlab = "i-th value", ylab = "Silhouette score for the i-th value",
		xlim = c(0, 200), ylim = c(-1, 1), type = 'h')
	plot(sc_scores_bad, main = "Sanity check (bad)",
		xlab = "i-th value", ylab = "Silhouette score for the i-th value",
		xlim = c(0, 200), ylim = c(-1, 1), type = 'h')
	plot(bm_scores, main = "Binary matrix",
		xlab = "iteration", type = 'b', pch = 21, cex = 1.5, bg = "black",
		ylab = "Average Silhouette score for the i-th iteration")
	dev.off()
}
