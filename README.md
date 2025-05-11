# Forutune Password Generator



This is a password generator that generates random passwords based on forutune cookie messages. It uses the `fortune` command to get random messages.


## Usage

Usage: fortune-passgen.sh [options] [num_words]

Options:
  -h            Show this help message and exit
  -u            Keep uppercase letters in the generated words
  -p            Include punctuation in the generated words
  -n NUM        Generate NUM passwords (default: 1)

Arguments:
  num_words     Number of words to generate per password (default: 4)

## Example

```bash
$ ./fortune-passgen.sh -n 3 3
advice=again#healthy
dolavimus%pohls*opinion
object~property+waste
```

## Installation

```bash
curl -O https://raw.githubusercontent.com/matejsmycka/fortune-passgen/refs/heads/main/fortune-passgen.sh 
chmod +x fortune-passgen.sh
sudo mv fortune-passgen.sh /usr/local/bin/fortune-passgen
```