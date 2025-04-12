#!/bin/bash

# Build the Docker image
docker build -t zombie-cows-game .

# Run the Docker container interactively and remove it after execution
docker run -it --rm zombie-cows-game
