compute_avg_Silhouette <- function(matrix) {
	# Import the package
	library(Kira)

	# Apply k-means on the dataset, with 2 centroids
	clustering_result <- silhouette(matrix, k.cluster = 2,
	                                plot = FALSE, savptc = FALSE)

	# Extract the average Silhouette score
	sil_avg <- clustering_result$eve.si

	# WHY WON'T YOU WORK
	file.remove("Rplots.pdf")

	return(sil_avg)
}
