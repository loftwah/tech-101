import os
import sys

import constants
# from langchain.document_loaders import TextLoader
from langchain.document_loaders import DirectoryLoader
from langchain.indexes import VectorstoreIndexCreator
from langchain.llms import OpenAI
from langchain.chat_models import ChatOpenAI

os.environ["OPENAI_API_KEY"] = constants.OPENAI_API_KEY

query = sys.argv[1]
print(query)

# loader = TextLoader('data/data.txt')
loader = DirectoryLoader("data/", glob="*.txt")
index = VectorstoreIndexCreator().from_loaders([loader])

# print(index.query(query, llm=ChatOpenAI()))
print(index.query(query))