# Import the MASS library
library(MASS)

# GOOD DATASET

# Generate two datapoints with a bivariate normal distribution
normal_A <- mvrnorm(n = 100, Sigma = matrix(c(0.5, 0.25, 0.25, 0.5),
                    nrow = 2, ncol = 2), mu = c(-5, 5))
normal_B <- mvrnorm(n = 100, Sigma = matrix(c(0.5, 0.25, 0.25, 0.5),
                    nrow = 2, ncol = 2), mu = c(5, -5))

# Merge the two together in one dataset
dataset <- rbind(normal_A, normal_B)

# Coerce into a dataframe
sc_dataset_good <- as.data.frame(dataset)
colnames(sc_dataset_good) <- c("X", "Y")

# Write to output file
write.csv(sc_dataset_good, "sc_dataset_good.csv", row.names = FALSE)

# Dump the plot of the dataset
pdf("sc_dataset_good.pdf")
plot(sc_dataset_good, main = "Sanity check dataset", xlab = "X", type = 'p',
     pch = 21, cex = 1.5, ylab = "Y")

# BAD DATASET

# Generate a datapoint with a bivariate normal distribution

normal_C <- mvrnorm(n = 200, Sigma = matrix(c(10, 5, 5, 10),
                    nrow = 2, ncol = 2), mu = c(0, 0))

# Coerce into a dataframe
sc_dataset_bad <- as.data.frame(normal_C)
colnames(sc_dataset_bad) <- c("X", "Y")

# Write to output file
write.csv(sc_dataset_bad, "sc_dataset_bad.csv", row.names = FALSE)

# Dump the plot of the dataset
pdf("sc_dataset_bad.pdf")
plot(sc_dataset_bad, main = "Sanity check bad dataset", xlab = "X", type = 'p',
     pch = 21, cex = 1.5, ylab = "Y")
