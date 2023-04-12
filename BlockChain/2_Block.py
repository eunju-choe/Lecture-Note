import hashlib
import json
from time import time

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
    print(hashlib.sha256(block_string))  
    return hashlib.sha256(block_string).hexdigest() # 16진수 숫자만 포함하는 두 배 길이의 문자열 객체로 반환



new_block(nonce=100, previous_hash=1) # gensis block
print(chain) # 최초의 블록만 있는 체인 출력
print(json.dumps(chain, indent=2)) # 보기 좋은 json형식으로 체인 출력

new_transactions('john1','smith1', 50) # 트랜잭션 추가
new_transactions('john2','smith2', 100) # 트랜잭션 추가
new_transactions('john3','smith3', 150) # 트랜잭션 추가

# 블록에 추가
new_block(nonce=101, current_transactions=current_transactions) # 지금은 nonce를 임의로 지정
print(json.dumps(chain, indent=2)) # 체인 출력

print("################### 트랜잭션 초기화 확인 ###################")
print(current_transactions)
