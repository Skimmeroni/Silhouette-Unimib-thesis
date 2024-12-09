plot_results <- function(sc_score_good, sc_score_bad, bms, package_name, time) {
	filename <- paste("results/results_", toupper(package_name), ".pdf",
	                  sep = "")

	sc_dataset_good <- read.csv("data/sc_dataset_good.csv")
	sc_dataset_bad <- read.csv("data/sc_dataset_bad.csv")

	pdf(filename)
	plot(sc_dataset_good, xlab = "X", ylab = "Y", type = 'p', pch = 21,
	     main = paste("Sanity check (good) \n Average Silhouette score: ",
	     sc_score_good, "\n Time to complete: ", time, " seconds", sep = ""))
	plot(sc_dataset_bad, xlab = "X", ylab = "Y", type = 'p', pch = 21,
	     main = paste("Sanity check (bad) \n Average Silhouette score: ",
	     sc_score_bad, "\n Time to complete: ", time, " seconds", sep = ""))
	plot(bms, main = paste("Binary matrix \n Time to complete: ", time,
	     " seconds", sep = ""), xlab = "iteration", type = 'b', pch = 21,
	     ylab = "Average Silhouette score for the i-th iteration", cex = 1.5,
	     bg = "black")
	dev.off()
}
