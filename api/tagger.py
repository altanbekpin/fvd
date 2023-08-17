from flask import request, jsonify
from app import app
import os
from db import DB
from tokenizers import Tokenizer
from tokenizers.trainers import BpeTrainer
from tokenizers.models import BPE
from tokenizers.pre_tokenizers import Whitespace

existing_file = "structured.txt"
target_file = "target.txt"
app.last_tagget_sentence_id = DB.get_instance().get_last_sentence()

def get_specific_line(filename, line_number):
    with open(filename, 'r', encoding="utf-8") as file:
        for _ in range(line_number - 1):
            file.readline()
        return file.readline().strip()

def build_tokenizer():
    # Initialize a tokenizer
    tokenizer = Tokenizer(BPE(unk_token="[UNK]"))

    # Customize pre-tokenization and decoding
    tokenizer.pre_tokenizer = Whitespace()

    # Initialize a trainer, which will train the tokenizer
    trainer = BpeTrainer(special_tokens=["[UNK]", "[CLS]", "[SEP]", "[PAD]", "[MASK]"])

    # Train the tokenizer
    files = [existing_file]  # Replace with the path to your large text file(s)
    tokenizer.train(files, trainer)

    # Save the tokenizer
    tokenizer.save("kazakh-bpe.tokenizer.json")
    app.tokenizer = Tokenizer.from_file("kazakh-bpe.tokenizer.json")


@app.route("/tokenizer/getinfo", methods=['GET'])
def get_info():
    # print(app.last_tagget_sentence_id)
    vocab = app.tokenizer.get_vocab()
    num_tokens = len(vocab)
    return jsonify(numtokens= num_tokens),200
@app.route("/tokenizer/getnexttaggingline", methods=['GET'])
def get_next_tagging_line():
    sent = get_specific_line(existing_file, app.last_tagget_sentence_id)
    app.last_tagget_sentence_id+=1 
    output = app.tokenizer.encode(sent)
    result = {'tokens': output.tokens, 'sentence': sent}
    return result
@app.route('/tokenize', methods=['POST', 'OPTIONS'])
def upload_token_file():
    # Имена файлов

    data = request.files
    for key in data.keys():
        file_storage = data.get(key)
        content_type = file_storage.content_type
        content_type = content_type.split("/")[1]
        try:
            file_storage.filename = target_file
            file_storage.save(target_file)
            # Проверьте, существует ли целевой файл
            if not os.path.exists(existing_file):
                # Если файл не существует, создайте его
                with open(existing_file, 'w') as f:
                    f.close()
            # Откройте оба файла и объедините их
            fin = open(target_file, "r")
            data2 = fin.read()
            fin.close()
            fout = open(existing_file, "a")
            fout.write(data2)
            fout.close()
            build_tokenizer()
        except Exception as e:
            return 'File uploading failed', 400
        print(f"File {file_storage.filename} with content type {content_type} uploaded with key '{key}'")
    return 'File uploaded successfully', 200