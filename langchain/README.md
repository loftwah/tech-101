# Langchain

Langchain is a language processing project using Python and the OpenAI GPT model.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine.

### Prerequisites

- Python 3.11
- Docker (optional)

### Configuration

Before you can run the Langchain application, you need to supply your own `constants.py` file in the root of the project directory, which contains your OpenAI API key:

```python
OPENAI_API_KEY = "your-key-here"
```

Your own data needs to be in the `data/*.txt` files. The model will process the data in the order of the files in the `data/` directory.

### Running the Application

To run the application locally without Docker: (I had issues on WSL2 Ubuntu and it only works in Docker)

```bash
python chatgpt.py "your-query-here"
```

### Running with Docker

To build the Docker image:

```bash
docker build -t loftwahgpt:latest .
```

To run the application with Docker:

```bash
docker run -it --rm loftwahgpt:latest "your-query-here"
```
