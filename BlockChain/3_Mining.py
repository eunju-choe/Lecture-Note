import hashlib
import json
from time import time
# import random

chain = []
current_transactions = []

def new_transactions(sender, recipient, amount):
    current_transactions.append({
      'sender': sender,
      'recipient': recipient,
      'amount': amount
    })

    return current_transactions

def new_block(nonce, current_transactions=None, previous_hash=None):
    block = {
      'index': len(chain)+1,
      'timestamp': time(),
      'transactions': current_transactions,
      'nonce': nonce,
      'previous_hash': previous_hash or hash(chain[-1])
    }

    chain.append(block)
    initialize_transactions()

    return block

def initialize_transactions():
  global current_transactions
  current_transactions = []

def hash(block):
    block_string = json.dumps(block, sort_keys=True).encode()
    return hashlib.sha256(block_string).hexdigest() # 16진수 숫자만 포함하는 두 배 길이의 문자열 객체로 반환

def last_block(chain):
  return chain[-1]

def proof_of_work(prev_block):
    nonce = 0
    # nonce = random.randint(1, 999999999)
    # count = 0
    prev_block_hash = hash(prev_block)
    while valid_proof(prev_block_hash, current_transactions, nonce) is False:
      nonce += 1
      # nonce = random.randint(1, 999999999)
      # count += 1
    new_transactions('system','me', 50) # 채굴 보상
    new_block(nonce=nonce, current_transactions=current_transactions)
    # print("count : {}\nnonce : {}".format(count, nonce))
    print()
    # return nonce

def valid_proof(prev_block_hash, current_transactions, nonce):
    # guess = str(prev_nonce*nonce).encode()
    guess = (str(prev_block_hash)+str(current_transactions)+str(nonce)).encode()
    guess_hash = hashlib.sha256(guess).hexdigest()
    print(guess_hash, end="\r")
    return guess_hash[:3] == "000"


new_block(nonce=100, previous_hash=1) # gensis block
print(chain)
print(json.dumps(chain, indent=2))

new_transactions('john1','smith1', 50)
new_transactions('john2','smith2', 100)
new_transactions('john3','smith3', 150)
# print(last_block, "\n", current_transactions)
proof_of_work(last_block(chain))
print(json.dumps(chain, indent=2))

print(current_transactions)

print("################### 트랜잭션 초기화 확인 ###################")
print(current_transactions)
