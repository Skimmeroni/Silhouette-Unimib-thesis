plot_results <- function(scs_good, scs_bad, bms, package_name) {
	filename <- paste("results/results_", toupper(package_name), ".pdf",
	                  sep = "")
	pdf(filename)
	par(mfrow = c(1, 3))
	plot(scs_good, main = "Sanity check (good)",
		xlab = "i-th value", ylab = "Silhouette score for the i-th value",
		xlim = c(0, 200), ylim = c(-1, 1), type = 'h')
	plot(scs_bad, main = "Sanity check (bad)",
		xlab = "i-th value", ylab = "Silhouette score for the i-th value",
		xlim = c(0, 200), ylim = c(-1, 1), type = 'h')
	plot(bms, main = "Binary matrix",
		xlab = "iteration", type = 'b', pch = 21, cex = 1.5, bg = "black",
		ylab = "Average Silhouette score for the i-th iteration")
	dev.off()
}
