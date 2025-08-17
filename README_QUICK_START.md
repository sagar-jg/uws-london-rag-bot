# 🚀 Quick Start Guide

**Get the UWS London RAG Chatbot running in 5 minutes!**

## 📋 Prerequisites

- Python 3.10+
- Docker & Docker Compose
- OpenAI API key
- Pinecone API key

## ⚡ One-Command Setup

```bash
# Clone and start everything
git clone https://github.com/sagar-jg/uws-london-rag-bot.git
cd uws-london-rag-bot
make dev-setup
```

## 🔧 Environment Setup

1. **Copy environment file:**
   ```bash
   cp .env.example .env
   ```

2. **Add your API keys to `.env`:**
   ```env
   OPENAI_API_KEY="your-openai-key-here"
   PINECONE_API_KEY="your-pinecone-key-here"
   ```

## 🚀 Start the Application

```bash
# Start all services
docker-compose up -d

# OR run locally
make run
```

## ✅ Test It Works

**Open your browser:** http://localhost:8000/docs

**Test the API:**
```bash
curl -X POST "http://localhost:8000/api/v1/chat" \
  -H "Content-Type: application/json" \
  -d '{
    "message": "What are the tuition fees?",
    "session_id": "test_session_123"
  }'
```

## 🎯 What You Get

- ✅ **Chat API** at http://localhost:8000/api/v1/chat
- ✅ **Health Check** at http://localhost:8000/api/v1/health  
- ✅ **API Docs** at http://localhost:8000/docs
- ✅ **PostgreSQL** database with sample data
- ✅ **Vector Search** with Pinecone integration
- ✅ **Intelligent Agent** with LangGraph

## 🔍 Quick Commands

```bash
# Check health
make health

# View logs  
docker-compose logs -f app

# Run tests
make test

# Stop everything
docker-compose down
```

## 📖 Next Steps

- **Full Documentation:** [README.md](README.md)
- **API Documentation:** [docs/api_documentation.md](docs/api_documentation.md)
- **Deployment Guide:** [docs/deployment_guide.md](docs/deployment_guide.md)
- **Contributing:** [CONTRIBUTING.md](CONTRIBUTING.md)

## 🆘 Troubleshooting

**Database connection issues?**
```bash
make setup-db
```

**Vector database issues?**
```bash
make populate-vectordb
```

**Port already in use?**
```bash
# Change port in .env
PORT=8001
```

**Need help?** Check the [full README](README.md) or create an [issue](https://github.com/sagar-jg/uws-london-rag-bot/issues).

---

**🎉 You're ready to chat with the UWS London RAG Chatbot!**