# frozen_string_literal: true

require 'asciidoctor'
require 'reverse_markdown'
require 'optparse'

class DocumentConversionService
  def self.call
    new.call
  end

  def call
    options = parse_options
    input_file = ARGV[0]
    output_directory = ARGV[1]
    content = read_input_file(input_file)
    converted_content = convert(content, options)
    write_output_file(output_directory, input_file, converted_content, options)
  end

  private

  def parse_options
    options = {}
    OptionParser.new do |opts|
      opts.banner = 'Usage: ruby convert_documents.rb [options] <input_file> <output_directory>'

      opts.on('-f', '--from FORMAT', 'Source format: asciidoc or markdown') do |format|
        options[:from] = format
      end

      opts.on('-t', '--to FORMAT', 'Target format: asciidoc or markdown') do |format|
        options[:to] = format
      end
    end.parse!
    options
  end

  def read_input_file(input_file)
    File.read(input_file)
  end

  def convert(content, options)
    if options[:from] == 'asciidoc' && options[:to] == 'markdown'
      convert_asciidoc_to_markdown(content)
    elsif options[:from] == 'markdown' && options[:to] == 'asciidoc'
      convert_markdown_to_asciidoc(content)
    else
      puts 'Invalid conversion options.'
      exit(1)
    end
  end

  def convert_asciidoc_to_markdown(content)
    html = Asciidoctor.convert(content, safe: :safe, backend: :html5)
    ReverseMarkdown.convert(html)
  end

  def convert_markdown_to_asciidoc(content)
    html = ReverseMarkdown.convert(content, unknown_tags: :bypass)
    Asciidoctor.convert(html, safe: :safe, backend: :asciidoctor)
  end

  def write_output_file(output_directory, input_file, converted_content, options)
    output_filename = File.basename(input_file, '.*') + '.' + options[:to]
    output_filepath = File.join(output_directory, output_filename)
    File.write(output_filepath, converted_content)
  end
end

# Run the Document Conversion Service
DocumentConversionService.call
