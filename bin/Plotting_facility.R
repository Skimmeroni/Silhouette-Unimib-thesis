plot_results <- function(sc_score_good, sc_score_bad, bms, package_name) {
	filename <- paste("results/results_", toupper(package_name), ".pdf",
	                  sep = "")

	sc_dataset_good <- read.csv("data/sc_dataset_good.csv")
	sc_dataset_bad <- read.csv("data/sc_dataset_bad.csv")

	pdf(filename)
	plot(sc_dataset_good, xlab = "X", ylab = "Y", type = 'p', pch = 21,
	     main = paste("Sanity check (good), average score: ", sc_score_good,
	     sep = ""))
	plot(sc_dataset_bad, xlab = "X", ylab = "Y", type = 'p', pch = 21,
	     main = paste("Sanity check (bad), average score: ", sc_score_bad,
	     sep = ""))
	plot(bms, main = "Binary matrix", xlab = "iteration",
	     type = 'b', pch = 21, cex = 1.5, bg = "black",
	     ylab = "Average Silhouette score for the i-th iteration")
	dev.off()
}
