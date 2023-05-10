# Dockerfile to run convert_document.rb with the following docker-compose run document_converter ruby convert_documents.rb -f asciidoc -t markdown example.adoc output_directory/

FROM ruby:2.7

RUN apt-get update && apt-get install -y \
  pandoc \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .