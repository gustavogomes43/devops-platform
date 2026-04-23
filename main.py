cat <<EOF > main.py
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "DevOps Platform Online!", "status": "Healthy"}

@app.get("/health")
def health_check():
    return {"status": "ok"}
EOF
