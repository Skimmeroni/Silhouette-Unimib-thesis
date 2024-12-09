plot_results <- function(sc_score_good, sc_score_bad, bms, package_name, time) {
	filename <- paste("results/results_", toupper(package_name), ".pdf",
	                  sep = "")

	sc_dataset_good <- read.csv("data/sc_dataset_good.csv")
	sc_dataset_bad <- read.csv("data/sc_dataset_bad.csv")

	pdf(filename)
	plot(sc_dataset_good, xlab = "X", ylab = "Y", type = 'p', pch = 21,
	     main = paste("Sanity check (good) for package: ", package_name,
	     "\n Average Silhouette score: ", sc_score_good, "\n Completed in: ",
	     time, " seconds", sep = ""))
	plot(sc_dataset_bad, xlab = "X", ylab = "Y", type = 'p', pch = 21,
	     main = paste("Sanity check (bad) for package: ", package_name,
	     "\n Average Silhouette score: ", sc_score_bad, "\n Completed in: ",
	     time, " seconds", sep = ""))
	plot(bms, main = paste("Binary matrix for package: ", package_name,
	     "\n Completed in: ", time, " seconds", sep = ""), xlab = "iteration",
	     ylab = "Average Silhouette score for the i-th iteration",
	     type = 'b', pch = 21, cex = 1.5, bg = "black")
	dev.off()
}
