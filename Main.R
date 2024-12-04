packages <- c("cluster", "drclust", "tidyclust", "rguhi",
              "TDA", "optpart", "Kira", "didec")

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

	sc_scores_good <- sanity_check_good(this_package)
	sc_scores_bad <- sanity_check_bad(this_package)
	bm_scores <- binary_matrix(8, 4, this_package)
	plot_results(sc_scores_good, sc_scores_bad, bm_scores, this_package)
}
