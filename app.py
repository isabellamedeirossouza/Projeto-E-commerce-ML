import os
from dotenv import load_dotenv
from supabase import create_client, Client

# 1. Carrega as variáveis de ambiente do arquivo .env
load_dotenv()

# 2. Configurações de acesso (buscando do .env)
url: str = os.getenv("SUPABASE_URL")
key: str = os.getenv("SUPABASE_KEY")

# 3. Inicializa o cliente do Supabase
supabase: Client = create_client(url, key)

def testar_conexao():
    print("Iniciando teste de conexão profissional...")
    
    try:
        # 4. Exploração: selecionando as primeiras 5 linhas da tabela 'teste'
        # O .limit(5) é essencial para boas práticas em Ciência de Dados
        response = supabase.table('teste').select("*").limit(5).execute()
        
        print("Conexão validada com sucesso via .env!")
        print("-" * 30)
        print("Primeiras linhas da tabela 'teste':")
        
        if response.data:
            for registro in response.data:
                print(registro)
        else:
            print("A tabela está conectada, mas não contém dados no momento.")
            
    except Exception as e:
        print(f"Erro ao conectar ou explorar o banco: {e}")

if __name__ == "__main__":
    testar_conexao()