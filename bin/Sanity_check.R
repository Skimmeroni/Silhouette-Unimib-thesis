avg_sil_score_for_sc <- function(package_name, dataframe) {
	# Coerce the dataframe into a matrix
	sc_matrix <- as.matrix(dataframe)

	# Compute the Silhouette widths
	avg_sil_score <- compute_avg_Silhouette(sc_matrix)

	# Round to two digits
	avg_sil_score <- round(avg_sil_score, digits = 2)

	return(avg_sil_score)
}
