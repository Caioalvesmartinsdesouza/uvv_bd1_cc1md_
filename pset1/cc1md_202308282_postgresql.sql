-- Caio Alves Martins de Souza
-- Turma CCM1D
---------------------------------------------------------
-- Exclui banco de dados uvv existente.
DROP DATABASE IF EXISTS uvv;
-- Exclui usuário Caio existente.
DROP USER IF EXISTS Caio;
-- Cria usuário Caio com senha computacao@raiz.
CREATE USER Caio WITH CREATEDB CREATEROLE ENCRYPTED PASSWORD 'computcao@raiz';
-- Cria banco de dados uvv.
CREATE DATABASE uvv WITH
OWNER = Caio
TEMPLATE = template0
ENCODING = 'UTF8'
LC_COLLATE = 'pt_BR.UTF-8'
LC_CTYPE = 'pt_BR.UTF-8'
ALLOW_CONNECTIONS = TRUE;
-- Usagem do banco de dados uvv.
\c uvv;
-- Usagem do usuário Caio.
SET ROLE Caio;
-- Cria o esquema lojas com autorização ao usuário Caio.
CREATE SCHEMA IF NOT EXISTS lojas AUTHORIZATION Caio;
-- Torna a mudança para usuário Caio permanente.
ALTER USER Caio;
SET SEARCH_PATH TO lojas, "$user", public;
-- Checa se todas as mudanças foram feitas com sucesso.
SELECT CURRENT_SCHEMA();
SHOW SEARCH_PATH;
SELECT CURRENT_DATABASE();
SELECT CURRENT_USER;
-- Cria a tabela produtos.
CREATE TABLE lojas.produtos (
                produto_id                NUMERIC(38)  NOT NULL,
                nome                      VARCHAR(255) NOT NULL,
                preco_unitario            NUMERIC(10,2),
                detalhes                  BYTEA,
                imagem                    BYTEA,
                imagem_mime_type          VARCHAR(512),
                imagem_arquivo            VARCHAR(512),
                imagem_charset            VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produto_id     PRIMARY KEY (produto_id)
);
COMMENT ON TABLE lojas.produtos                            IS 'Tabela de indentifição de produtos e informações relevantes dos mesmos.';
COMMENT ON COLUMN lojas.produtos.produto_id                IS 'Chave primária de indetificação de produtos, chave numérica de até 38 caractéres, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.produtos.nome                      IS 'Nome do respectivo produto, armazena até 255 caratéres em ASCII, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.produtos.preco_unitario            IS 'Preço equivalente a uma unidade do produto, chave numérica de até 10 caractéres aceitando númeos não inteiros com até duas casas após a virgula.';
COMMENT ON COLUMN lojas.produtos.detalhes                  IS 'Informações de descrição do produto, armazenadas no formato blob que aceita imagem ou arquivo pdf.';
COMMENT ON COLUMN lojas.produtos.imagem                    IS 'Imagem do produto, armazenada no formato blob que aceita imagem ou arquivo pdf.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type          IS 'Tipo de arquivo ao qual a imagem pertence, armazena até 512 caratéres em ASCII.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo            IS 'Endereço digital em qual se localiza a imagem do produto, armazena até 512 caratéres em ASCII.';
COMMENT ON COLUMN lojas.produtos.imagem_charset            IS 'Tipo de characteres usáveis na codificação da imagem, armazena até 512 caratéres em ASCII.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Data respectiva a imagem mais recente do produto, formato padrão de data DATE.';
-- Cria a tabela lojas.
CREATE TABLE lojas.lojas (
                loja_id                 NUMERIC(38)   NOT NULL,
                nome                    VARCHAR(255)  NOT NULL,
                endereco_web            VARCHAR(100),
                endereco_fisico         VARCHAR(512),
                latitude                NUMERIC,
                longitude               NUMERIC,
                logo                    BYTEA,
                logo_mime_type          VARCHAR(512),
                logo_arquivo            VARCHAR(512),
                logo_charset            VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT loja_id      PRIMARY KEY (loja_id)
);
COMMENT ON TABLE lojas.lojas                          IS 'Tabela de indentifição de lojas e informações relevantes das mesmas.';
COMMENT ON COLUMN lojas.lojas.loja_id                 IS 'Chave primária de indetificação de lojas, chave numérica de até 38 caractéres, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.lojas.nome                    IS 'Nome da respectiva loja, armazena até 255 caratéres em ASCII, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.lojas.endereco_web            IS 'Endereço digital da web em qual se localiza o site da loja, armazena até 100 caratéres em ASCII.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico         IS 'Endereço físico em qual se localiza a loja, armazena até 512 caratéres em ASCII.';
COMMENT ON COLUMN lojas.lojas.latitude                IS 'Coordenada geográfica de lattitude da localição fisica da loja, chave numérica sem precisão.';
COMMENT ON COLUMN lojas.lojas.longitude               IS 'Coordenada geográfica de longitude da localição fisica da loja, chave numérica sem precisão.';
COMMENT ON COLUMN lojas.lojas.logo                    IS 'Imagem de logo utilizada pela loja, armazenada no formato blob que aceita imagem ou arquivo pdf.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type          IS 'Tipo de arquivo ao qual a imagem pertence, armazena até 512 caratéres em ASCII.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo            IS 'Endereço digital em qual se localiza a imagem do logo da loja, armazena até 512 caratéres em ASCII.';
COMMENT ON COLUMN lojas.lojas.logo_charset            IS 'Tipo de characteres usáveis na codificação da imagem, armazena até 512 caratéres em ASCII.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Data respectiva a imagem mais recente do logo da loja, formato padrão de data DATE.';
-- Cria a tabela estoques.
CREATE TABLE lojas.estoques (
                estoque_id             NUMERIC(38) NOT NULL,
                loja_id                NUMERIC(38) NOT NULL,
                produto_id             NUMERIC(38) NOT NULL,
                quantidade             NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id  PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE lojas.estoques             IS 'Tabela de indentifição de estoques e informações relevantes dos mesmos.';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Chave primária de indetificação de estoques, chave numérica de até 38 caractéres, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.estoques.loja_id    IS 'Chave estrangeira da chave primaria da tabela lojas por relação não indetificada, chave numérica de até 38 caractéres, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Chave estrangeira da chave primaria da tabela produtos por relação não indetificada, chave numérica de até 38 caractéres, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Quantidade do produto presente nesse estoque, chave numérica de até 38 caractéres, não pode ser deixada vazia.';
-- Cria a tabela clientes.
CREATE TABLE lojas.clientes (
                cliente_id             NUMERIC(38)  NOT NULL,
                email                  VARCHAR(255) NOT NULL,
                nome                   VARCHAR(255) NOT NULL,
                telefone1              VARCHAR(20),
                telefone2              VARCHAR(20),
                telefone3              VARCHAR(20),
                CONSTRAINT cliente_id  PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE lojas.clientes             IS 'Tabela de indentifição de clientes e informações relevantes dos mesmos.';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Chave primária de indetificação de clientes, chave numérica de até 38 caractéres, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.clientes.email      IS 'Email de contato do cliente, armazena até 255 caratéres em ASCII, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.clientes.nome       IS 'Nome do respectivo cliente, armazena até 255 caratéres em ASCII, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.clientes.telefone1  IS 'Primeiro número de telefone do cliente, armazena até 20 caratéres em ASCII.';
COMMENT ON COLUMN lojas.clientes.telefone2  IS 'Segundo número de telefone do cliente, armazena até 20 caratéres em ASCII.';
COMMENT ON COLUMN lojas.clientes.telefone3  IS 'Terceiro número de telefone do cliente, armazena até 20 caratéres em ASCII.';

-- Cria a tabela envios.
CREATE TABLE lojas.envios (
                envio_id             NUMERIC(38)  NOT NULL,
                loja_id              NUMERIC(38)  NOT NULL,
                cliente_id           NUMERIC(38)  NOT NULL,
                endereco_entrega     VARCHAR(512) NOT NULL,
                status               VARCHAR(15)  NOT NULL,
                CONSTRAINT envio_id  PRIMARY KEY (envio_id)
);
COMMENT ON TABLE lojas.envios                   IS 'Tabela de indentifição de envios e informações relevantes dos mesmos.';
COMMENT ON COLUMN lojas.envios.envio_id         IS 'Chave primária de indetificação de envios, chave numérica de até 38 caractéres, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.envios.loja_id          IS 'Chave estrangeira da chave primaria da tabela lojas por relação não indetificada, chave numérica de até 38 caractéres, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.envios.cliente_id       IS 'Chave estrangeira da chave primaria da tabela clientes por relação não indetificada, chave numérica de até 38 caractéres, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Endereço físico em qual se localiza o lugar de entrega do envio, armazena até 512 caratéres em ASCII, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.envios.status           IS 'Condição atual da entega, armazena até 15 caratéres em ASCII, não pode ser deixada vazia.';
-- Cria a tabela pedidos.
CREATE TABLE lojas.pedidos (
                pedido_id             NUMERIC(38) NOT NULL,
                data_hora             TIMESTAMP   NOT NULL,
                cliente_id            NUMERIC(38) NOT NULL,
                status                VARCHAR(15) NOT NULL,
                loja_id               NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id  PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE lojas.pedidos             IS 'Tabela de indentifição de pedidos e informações relevantes dos mesmos.';
COMMENT ON COLUMN lojas.pedidos.pedido_id  IS 'Chave primária de indetificação de pedidos, chave numérica de até 38 caractéres, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.pedidos.data_hora  IS 'Data e hora nas quais o pedido foi realizado, formato padrão de data e hora TIMESTAMP, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Chave estrangeira da chave primaria da tabela clientes por relação não indetificada, chave numérica de até 38 caractéres, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.pedidos.status     IS 'Estado atual do pedido, armazena até 15 caratéres em ASCII, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.pedidos.loja_id    IS 'Chave estrangeira da chave primaria da tabela lojas por relação não indetificada, chave numérica de até 38 caractéres, não pode ser deixada vazia.';

CREATE TABLE lojas.pedidos_itens (
                produto_id                       NUMERIC(38)   NOT NULL,
                pedido_id                        NUMERIC(38)   NOT NULL,
                numero_da_linha                  NUMERIC(38)   NOT NULL,
                preco_unitario                   NUMERIC(10,2) NOT NULL,
                quantidade                       NUMERIC(38)   NOT NULL,
                envio_id                         NUMERIC(38)   NOT NULL,
                CONSTRAINT produto_id__pedido_id PRIMARY KEY (produto_id, pedido_id)
);
COMMENT ON TABLE lojas.pedidos_itens IS 'Tabela de indentifição de elementos que compõem os pedidos e informações relevantes dos mesmos.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'Chave estrangeira da chave primaria da tabela produtos por relação indetificada, chave numérica de até 38 caractéres, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'Chave estrangeira da chave primaria da tabela pedidos por relação indetificada, chave numérica de até 38 caractéres, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Número da linha do produto na lista da ordem de pedido, chave numérica de até 38 caractéres, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Preço equivalente a uma unidade do produto,, chave numérica de até 10 caractéres aceitando númeos não inteiros com até duas casas após a virgula, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Quantidade do produto presente nesse pedido, chave numérica de até 38 caractéres, não pode ser deixada vazia.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Chave estrangeira da chave primaria da tabela envios por relação não indetificada, chave numérica de até 38 caractéres, não pode ser deixada vazia.';

-- Adição de todas as chaves estrangeiras.

--Adicona a chave estrangeira de referência a tabela de produtos na tabela de estoques por relação não indetificada.
ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES  lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Adicona a chave estrangeira de referência a tabela de produtos na tabela de componentes de pedidos por relação indetificada.
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES  lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Adicona a chave estrangeira de referência a tabela de lojas na tabela de pedidos por relação não indetificada.
ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES  lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Adicona a chave estrangeira de referência a tabela de lojas na tabela de estoques por relação não indetificada.
ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES  lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Adicona a chave estrangeira de referência a tabela de lojas na tabela de envios por relação não indetificada.
ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES  lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Adicona a chave estrangeira de referência a tabela de clientes na tabela de pedidos por relação não indetificada.
ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES  lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Adicona a chave estrangeira de referência a tabela de clientes na tabela de envios por relação não indetificada.
ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES  lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Adicona a chave estrangeira de referência a tabela de envios na tabela de componentes de pedidos por relação não indetificada.
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES  lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Adicona a chave estrangeira de referência a tabela de pedidos na tabela de componentes de pedidos por relação indetificada.
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES  lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Adição de restrições por CONSTRAINTS lógicas.

-- Restringe a quantidade do produto no estoque a valores positivos e possíveis.
ALTER TABLE lojas.estoques
ADD CONSTRAINT cc_estoques_quantidade_positiva
CHECK(quantidade > 0);
-- Restringe a quantidade do produto na lista de pedidos a valores positivos e possíveis.
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_quantidade_positiva
CHECK(quantidade > 0);
-- Restringe o preço unitário do produto a valores positivos e possíveis.
ALTER TABLE lojas.produtos
ADD CONSTRAINT cc_produtos_preco_unitario_positivo
CHECK(preco_unitario > 0);
-- Restringe o preço unitário do produto na lista de pedidos a valores positivos e possíveis.
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_preco_unitario_positivo
CHECK(preco_unitario > 0);
-- Restringe o status do pedido a situações possíveis.
ALTER TABLE lojas.pedidos
ADD CONSTRAINT cc_pedidos_status
CHECK(status IN('CANCELADO','COMPLETO','ABERTO','PAGO','REEMBOLSADO','ENVIADO'));
-- Restringe o status do envio a situações possíveis.
ALTER TABLE lojas.envios
ADD CONSTRAINT cc_envios_status
CHECK(status IN('CRIADO','ENVIADO','TRANSITO','ENTREGUE'));
-- Restringe a loja a ter um endereço existente seja este físico ou digital.
ALTER TABLE lojas.lojas
ADD CONSTRAINT cc_lojas_endereco_fisico_or_web
CHECK(endereco_fisico IS NOT NULL OR endereco_web IS NOT NULL);