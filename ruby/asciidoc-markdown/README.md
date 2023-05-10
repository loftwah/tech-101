# Document Conversion Service

This Ruby script, `convert_documents.rb`, provides a simple way to convert between AsciiDoc and Markdown formats using Docker Compose.

## Prerequisites

You'll need Docker and Docker Compose installed on your system.

## Build the Docker image

First, build the Docker image by running the following command in the directory containing the `Dockerfile` and `docker-compose.yml`:

```bash
docker-compose build
```

## Usage

To use the script with Docker Compose, run the following command:

```bash
docker-compose run --rm document_converter ruby convert_documents.rb [options] <input_file> <output_directory>
```

Where:

* `<input_file>` is the path to the input file in either AsciiDoc or Markdown format
* `<output_directory>` is the directory where the converted file will be saved

Options:

* `-f`, `--from FORMAT`: The source format of the input file (asciidoc or markdown)
* `-t`, `--to FORMAT`: The target format you want to convert the input file to (asciidoc or markdown)

For example, to convert an AsciiDoc file to Markdown:

```bash
docker-compose run --rm document_converter ruby convert_documents.rb -f asciidoc -t markdown example.adoc output_directory/
```

And to convert a Markdown file to AsciiDoc:

```bash
docker-compose run --rm document_converter ruby convert_documents.rb -f markdown -t asciidoc example.md output_directory/
```

## Testing

You can test the script with the provided example files:

1. Convert `example.adoc` to Markdown:

```bash
docker-compose run --rm document_converter ruby convert_documents.rb -f asciidoc -t markdown example.adoc output_directory/
```

2. Convert `example.md` to AsciiDoc:

`docker-compose run --rm document_converter ruby convert_documents.rb -f markdown -t asciidoc example.md output_directory/`

The converted files will be saved in the `output_directory` folder.
