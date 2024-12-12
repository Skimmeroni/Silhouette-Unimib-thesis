packages <- c("cluster", "drclust", "tidyclust", "Kira", "reticulate")

for (this_package in packages) {
	if (system.file(package = this_package) == "") {
		stop(c("Missing package: ", this_package))
	}
}

cat("All packages are installed. Proceeding... \n")
source("bin/Plotting_facility.R")
source("bin/Binary_matrix.R")
source("bin/Sanity_check.R")

for (this_package in packages) {
	cat("Current package:", this_package, "\n")
	s_time <- Sys.time()

	sc_score_good <- sanity_check(this_package, "data/sc_dataset_good.csv")
	sc_score_bad <- sanity_check(this_package, "data/sc_dataset_bad.csv")
	bm_scores <- binary_matrix(20, 10, this_package)

	f_time <- Sys.time() - s_time
	f_time <- round(f_time, digits = 2)

	plot_results(sc_score_good, sc_score_bad, bm_scores, this_package, f_time)
}

# ????????
for (i in list.files(pattern = "Rplots*")) {
	file.remove(i)
}
