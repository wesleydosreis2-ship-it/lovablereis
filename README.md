# LeadFlow — Leads & Financeiro

Dashboard responsivo em React para organizar leads de vendas pelo WhatsApp, pedidos, custos e despesas. Preparado para abrir no Lovable e usar Supabase como banco persistente.

## Funcionalidades
- Dashboard com faturamento bruto, lucro estimado, fretes e despesas por período.
- Gráficos interativos de faturamento/despesas e composição de custos.
- Cadastro, edição, pesquisa, filtro por status e exclusão de leads.
- Dados do contato, endereço, produto, data, valor da venda, frete, custo do produto, status de pagamento e observações.
- Importação de CSV e exportação de leads/despesas.
- Registro de despesas operacionais.
- Layout responsivo para desktop e celular.
- Modo local usando localStorage quando o Supabase ainda não foi configurado.

## Cálculo financeiro
Lucro estimado = faturamento bruto das vendas com status Vendido − custo dos produtos − fretes − despesas registradas. Vendas com pagamento pendente ainda contam como receita bruta; recebidos e pendentes são indicadores separados. Impostos, taxas de pagamento, devoluções e outros custos não são calculados automaticamente.

## Rodar localmente
Requer Node.js 18+.

1. Execute npm install.
2. Copie .env.example para .env.
3. Execute npm run dev.

Sem Supabase, os dados ficam somente no navegador atual e não sincronizam entre dispositivos.

## Configurar Supabase
1. Crie um projeto em https://supabase.com.
2. Abra SQL Editor e execute o arquivo supabase/schema.sql.
3. Em Project Settings → API, copie a Project URL e a chave publicável/anon.
4. Configure as variáveis de ambiente:
   - VITE_SUPABASE_URL=https://SEU-PROJETO.supabase.co
   - VITE_SUPABASE_ANON_KEY=SUA_CHAVE_PUBLICA
5. Reinicie o app. O indicador mostrará se o banco está conectado.

### Segurança
O SQL inicial usa políticas abertas para facilitar um protótipo e permite leitura/escrita por qualquer pessoa que alcance o projeto. Não publique dados reais de clientes com essas políticas. Antes de produção, configure Supabase Auth, adicione user_id às tabelas e restrinja as políticas RLS por usuário (auth.uid()). Nunca coloque a service_role key no frontend.

## Importar CSV
Na página Leads e vendas, escolha Importar CSV. A primeira linha deve conter cabeçalhos como Nome, Telefone, Endereço, Produto, Data, Valor pago, Frete, Custo do produto, Status, Pagamento e Observações. Use ponto e vírgula ou vírgula como separador. O app disponibiliza um modelo CSV. A importação adiciona registros e não deduplica contatos automaticamente.

## Abrir no Lovable
1. Conecte/importa este repositório no Lovable pela integração GitHub.
2. Deixe o Lovable instalar dependências e ler os arquivos.
3. Configure VITE_SUPABASE_URL e VITE_SUPABASE_ANON_KEY nas variáveis de ambiente.
4. Execute o SQL do banco antes de testar cadastros.
5. Teste cadastro, edição, importação e cálculos antes de usar com dados reais.

## Build
Execute npm run build e depois npm run preview para conferir a versão compilada.
