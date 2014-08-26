-- Script gerado em MySQL Work bench5.2.38
/*
Carlos Alberto, Luciano D'Alessandre, Matheus Lopes, Pedro Augusto Duarte - 10A
*/
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `Locadora` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `Locadora` ;

-- -----------------------------------------------------
-- Table `Locadora`.`Produtora`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Locadora`.`Produtora` (
  `idProdutora` INT NOT NULL auto_increment,
  `Nome` VARCHAR(60) NOT NULL ,
  PRIMARY KEY (`idProdutora`) )
ENGINE = InnoDB
PACK_KEYS = DEFAULT;


-- -----------------------------------------------------
-- Table `Locadora`.`Filmes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Locadora`.`Filmes` (
  `idFilme` INT NOT NULL auto_increment,
  `Titulo` VARCHAR(60) NOT NULL ,
  `Ano` INT NOT NULL ,
  `Classificação_Indicativa` INT NOT NULL ,
  `Tempo_de_Duracao` INT NOT NULL ,
  `Elenco` TEXT NOT NULL ,
  `idProdutora` INT NOT NULL ,
  PRIMARY KEY (`idFilme`) ,
  INDEX `fkProdutora` (`idProdutora` ASC) ,
  CONSTRAINT `fkProdutora`
    FOREIGN KEY (`idProdutora` )
    REFERENCES `Locadora`.`Produtora` (`idProdutora` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Locadora`.`Genero`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Locadora`.`Genero` (
  `idGenero` INT NOT NULL auto_increment,
  `Descricao` VARCHAR(10) NOT NULL ,
  PRIMARY KEY (`idGenero`) )
ENGINE = InnoDB
COMMENT = 'Contem os generos que os filmes podem assumir.';


-- -----------------------------------------------------
-- Table `Locadora`.`Cliente`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Locadora`.`Cliente` (
  `cpfCliente` INT NOT NULL ,
  `Nome` VARCHAR(20) NOT NULL ,
  `Sobrenome` VARCHAR(40) NOT NULL ,
  `Logradouro` VARCHAR(60) NOT NULL ,
  `Cidade` VARCHAR(20) NOT NULL ,
  `UF` VARCHAR(2) NOT NULL ,
  `Pais` VARCHAR(30) NOT NULL ,
  `CEP` INT NOT NULL ,
  `Numero` INT NOT NULL ,
  `Complemento` TEXT NOT NULL ,
  PRIMARY KEY (`cpfCliente`) )
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Locadora`.`Historico`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Locadora`.`Historico` (
  `cpfCliente` INT NOT NULL ,
  `idFilme` INT NOT NULL ,
  `Data_Vizualizacao` DATETIME NOT NULL ,
  INDEX `fk_Historico_Cliente1` (`cpfCliente` ASC) ,
  INDEX `fk_Historico_Filmes1` (`idFilme` ASC) ,
  PRIMARY KEY (`cpfCliente`, `idFilme`, `Data_Vizualizacao`) ,
  CONSTRAINT `fk_Historico_Cliente1`
    FOREIGN KEY (`cpfCliente` )
    REFERENCES `Locadora`.`Cliente` (`cpfCliente` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Historico_Filmes1`
    FOREIGN KEY (`idFilme` )
    REFERENCES `Locadora`.`Filmes` (`idFilme` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Locadora`.`Forma_de_Pagamento`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Locadora`.`Forma_de_Pagamento` (
  `idForma_de_Pagamento` INT NOT NULL auto_increment,
  `Tipo_de_Pagamento` CHAR NOT NULL ,
  PRIMARY KEY (`idForma_de_Pagamento`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Locadora`.`Assinatura`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Locadora`.`Assinatura` (
  `idAssinatura` INT NOT NULL auto_increment,
  `Data_Assinatura` DATE NOT NULL ,
  `Mensalidade` FLOAT NOT NULL ,
  `idForma_de_Pagamento` INT NOT NULL ,
  `cpfCliente` INT NOT NULL ,
  PRIMARY KEY (`idAssinatura`) ,
  INDEX `fk_Assinatura_Forma_de_Pagamento1` (`idForma_de_Pagamento` ASC) ,
  INDEX `fk_Assinatura_Cliente1` (`cpfCliente` ASC) ,
  CONSTRAINT `fk_Assinatura_Forma_de_Pagamento1`
    FOREIGN KEY (`idForma_de_Pagamento` )
    REFERENCES `Locadora`.`Forma_de_Pagamento` (`idForma_de_Pagamento` )
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Assinatura_Cliente1`
    FOREIGN KEY (`cpfCliente` )
    REFERENCES `Locadora`.`Cliente` (`cpfCliente` )
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Locadora`.`Telefones`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Locadora`.`Telefones` (
  `cpfCliente` INT NOT NULL ,
  `Telefone` INT NOT NULL ,
  INDEX `fk_Telefones_Cliente1` (`cpfCliente` ASC) ,
  PRIMARY KEY (`cpfCliente`, `Telefone`) ,
  CONSTRAINT `fk_Telefones_Cliente1`
    FOREIGN KEY (`cpfCliente` )
    REFERENCES `Locadora`.`Cliente` (`cpfCliente` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Locadora`.`Filme_Genero`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Locadora`.`Filme_Genero` (
  `idFilme` INT NOT NULL ,
  `idGenero` INT NOT NULL ,
  PRIMARY KEY (`idFilme`, `idGenero`) ,
  INDEX `fk_Filme_Genero_Filmes1` (`idFilme` ASC) ,
  CONSTRAINT `fk_Filme_Genero_Genero1`
    FOREIGN KEY (`idGenero` )
    REFERENCES `Locadora`.`Genero` (`idGenero` )
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Filme_Genero_Filmes1`
    FOREIGN KEY (`idFilme` )
    REFERENCES `Locadora`.`Filmes` (`idFilme` )
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Locadora`.`para_assistir`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Locadora`.`para_assistir` (
  `idAssinatura` INT NOT NULL ,
  `idFilme` INT NOT NULL ,
  INDEX `fk_para_assistir_Assinatura1` (`idAssinatura` ASC) ,
  INDEX `fk_para_assistir_Filmes1` (`idFilme` ASC) ,
  PRIMARY KEY (`idAssinatura`, `idFilme`) ,
  CONSTRAINT `fk_para_assistir_Assinatura1`
    FOREIGN KEY (`idAssinatura` )
    REFERENCES `Locadora`.`Assinatura` (`idAssinatura` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_para_assistir_Filmes1`
    FOREIGN KEY (`idFilme` )
    REFERENCES `Locadora`.`Filmes` (`idFilme` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Locadora`.`Cartao_de_credito`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Locadora`.`Cartao_de_credito` (
  `Nome_Cartão` VARCHAR(60) NOT NULL ,
  `Codigo_de_segurança` INT NOT NULL ,
  `Bandeira` VARCHAR(45) NOT NULL ,
  `idForma_de_Pagamento` INT NOT NULL ,
  INDEX `fk_Cartao_de_credito_Forma_de_Pagamento1` (`idForma_de_Pagamento` ASC) ,
  PRIMARY KEY (`idForma_de_Pagamento`) ,
  CONSTRAINT `fk_Cartao_de_credito_Forma_de_Pagamento1`
    FOREIGN KEY (`idForma_de_Pagamento` )
    REFERENCES `Locadora`.`Forma_de_Pagamento` (`idForma_de_Pagamento` )
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Locadora`.`Debito_em_Conta`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Locadora`.`Debito_em_Conta` (
  `Banco` VARCHAR(10) NOT NULL ,
  `Numero_da_Conta` INT NOT NULL ,
  `Data_Debito` INT NOT NULL ,
  `idForma_de_Pagamento` INT NOT NULL ,
  INDEX `fk_Debito_em_Conta_Forma_de_Pagamento1` (`idForma_de_Pagamento` ASC) ,
  PRIMARY KEY (`idForma_de_Pagamento`) ,
  CONSTRAINT `fk_Debito_em_Conta_Forma_de_Pagamento1`
    FOREIGN KEY (`idForma_de_Pagamento` )
    REFERENCES `Locadora`.`Forma_de_Pagamento` (`idForma_de_Pagamento` )
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

﻿-- ---------------------------------------------------------------------------------------------
-- (b) Exemplos de ALTER TABLE (pelo menos 3 exemplos, envolvendo alterações diversas) e DROP TABLE;
/*
        -- 1)Inclusão da restrição check na tabela Tipo_de_Pagamento.
        alter table Forma_de_Pagamento add check(  Tipo_de_Pagamento = 'c' or Tipo_de_Pagamento = 'd' ); 

        -- 2)Inclusão da coluna Apelido( varchar 10) na tabela Cliente.
        alter table Cliente add Apelido varchar(10) not null;

        -- 3)Exlusão da coluna Apelido da tabela Cliente.
        alter table Cliente drop column Apelido;

        -- 4)Alterar o tipo da coluna Data_Debito da tabela 
        ALTER TABLE `Locadora`.`Debito_em_Conta` CHANGE COLUMN `Data_Debito` `Data_Debito` INT(11) NOT NULL  ;
*/
-- ---------------------------------------------------------------------------------------------
-- (c) Exemplos de inserção de dados em cada uma das tabelas;
-- pk dos dados das tabelas tabelas:
-- 123 Cliente
-- 456 Assinatura
-- 789 Forma de pagamento
-- 1234 Filme
-- 5678 Genero
-- 01 Produtora
/*
        insert into Produtora values ( 01, 'Warner' ); 
        insert into Genero values ( 5678, 'Ação' );
        insert into Filmes values ( 1234, 'Os mercenarios', 2012, 18, 60, 'Silvestre Estalone KKKK', 01);
        insert into Filme_Genero values ( 1234, 5678 );    
        insert into Cliente values ( 123, 'Luciano', 'D Alessandre', 'Rua 13 de maio - centro', 'Lavras', 'MG', 'Brasil', 13600000, 999, 'Casa');
        insert into Telefones values ( 123, 9999-9999 );
        insert into Forma_de_Pagamento values ( 789, 'd' ); 
        insert into Assinatura values ( 456, curdate(), 17.99, 789, 123);
        insert into Cartao_de_credito values ( 'Pedro', 666, 'Visa', 789);
        insert into Debito_em_Conta values ( 'Banco do Brasil', 1234567890, 01, 789 ); 
        insert into Historico values ( 123, 1234, curdate() ); 
        insert into para_assistir values ( 456, 1234 );
*/
-- ---------------------------------------------------------------------------------------------
-- (d) Exemplos de modificação de dados em 5 tabelas. Mostre pelo menos um exemplo com UPDATE aninhado, envolvendo mais de uma tabela;
/*
        update Cliente set CEP = 0 where cpfCliente = 123;
        update Filmes set Titulo = 'Os Mercenarios 2' where idFilme = 1234;
        update Debito_em_Conta set Numero_da_Conta = 0987654321 where idForma_de_Pagamento = 789;
        update Cartao_de_credito set Codigo_de_seguranca = 111 where idForma_de_Pagamento = 789;
 
        update Assinatura 
        set Mensalidade = Mensalidade / 1.1 
        where cpfCliente = ( select Hist.cpfCliente 
        from ( select cpfCliente, count(cpfCliente) as Contador from Historico group by cpfCliente desc ) as Hist limit 1);
*/
-- ---------------------------------------------------------------------------------------------
-- (e) Exemplos de exclusão de dados em 5 tabelas. Mostre pelo menos um exemplo com DELETE aninhado, envolvendo mais de uma tabela;
/*
        delete from Historico where cpfCliente = 123;
        DELETE FROM Filmes where idFilme = 1234;
        DELETE FROM Genero WHERE idGenero = 5678;
        delete from Pocutora where idProdutora = 01;
        delete from Assinatura where cpfCliente = ( select cpfCliente from Historico group by cpfCliente asc limit 1 );
*/
-- ---------------------------------------------------------------------------------------------
-- (f) Exemplos de 12 consultas. Inclua consultas simples e complexas, envolvendo todas
-- as cláusulas do comando SELECT estudadas (FROM, WHERE, JOIN, OUTER
-- JOIN, GROUP BY, HAVING, ORDER BY, UNION, INTERSECT, MINUS), os
-- operadores (AND, OR, NOT, BETWEEN, IN, LIKE, IS NULL, ANY, SOME, ALL,
-- EXISTS), além de funções agregadas e consultas aninhadas (subconsultas). Não faça
-- aninhamentos "forçados", somente os use em situações onde é difícil escrever uma
-- consulta sem aninhamento. Será avaliado o nível de complexidade das consultas
-- apresentadas. Não se esqueça de descrever em detalhes o que cada consulta recupera
-- (ex: recupera o nome e o endereço dos gerentes dos departamentos que controlam os
-- projetos localizados em Lavras);
/*
    -- 01 Consultar de forma ornedana o cpf dos clientes que viram pelo menos 1 filme.
        select 
            cpfCliente
        from
            Historico
        group by cpfCliente asc;

    -- 02 Consultar todos os nomes dos clientes, filmes e data visualização.
        select distinct
            c.Nome, d.Data_Vizualizacao, f.Titulo
        from
            Historico as d
                inner join
            Cliente as c,
            Filmes as f
        where
            c.cpfCliente = d.cpfCliente and f.idFilme = d.idFilme;        
    
    -- 03 Consultar o Nome e o telefone de cada cliente.
        select 
            c.Nome, t.Telefone
        from
            Telefones as t
                join
            Cliente as c
        where
            c.cpfCliente = t.cpfCliente
        group by c.Nome asc ;
    
    -- 04 Consultar o valor da mensalidade de cada cliente.
        select 
            c.Nome, a.Mensalidade
        from
            Cliente as c
                inner join
            Assinatura as a;

    -- 05 Consultar o valor das 3 mensalidades mais altas.     
        select 
            c.Nome, a.Mensalidade
        from
            Cliente as c
                inner join
            Assinatura as a
        where
            c.cpfCliente = a.cpfCliente
        group by a.Mensalidade asc
        limit 3;    

    -- 06 Quais clientes viram quais filmes?   
        select DISTINCT
            h.cpfCliente, h.idFilme
        from
            Historico as h;

    -- 07 Consultar Clientes pertencentes a Lavras
        select 
            Nome
        from
            Cliente
        where
            Cidade = 'Lavras';

    -- 08 Consultar o numero de pessoas que tem forma de pagamento como credito e debito.
        select 
            Tipo_de_Pagamento, count(Tipo_de_Pagamento) as Contagem
        from
            Forma_de_Pagamento
        group by Tipo_de_Pagamento
        having count(idForma_de_Pagamento) > 0;

    -- 09 Consultas Filmes que tem algum padrão noi titulo.Por exemplo uma continuação, ou seja LIKE '%2%';
        select 
            Titulo
        from
            Filmes
        where
            Titulo like '%algum padrão%'; 

    -- 10 Consultar os filmes vistos pelos clientes de uma cidade com nome parecido(LIKE '%Lavras%').
        select 
            f.Titulo, s.contagem
        from
            Filmes as f
                inner join
            (select 
                h.idFilme, count(h.idFilme) as contagem
            from
                Historico as h
            join Cliente as c ON c.cpfCliente = h.cpfCliente
            where
                c.Cidade like '%Lavras%'  
            group by h.idFilme
            having count(h.idFilme) > 0) as s ON f.idFilme = s.idFilme
        order by s.contagem desc; 

    -- 11 Consular os filmes que foram vistos a partir de uma data incial até a data atual.
        select 
            f.Titulo, h.Data_Vizualizacao
        from
            Historico as h
                join
            Filmes as f ON f.idFilme = h.idFilme
        where
            h.Data_Vizualizacao between 2013 - 08 - 01 and curdate() ;

    -- 12 Consultar os generos de uma determinada produtora, no caso idProdutora = 1.
        select 
            Descricao
        from
            Genero
                inner join
            (select 
                g.idGenero as genero
            from
                Filme_Genero as g, (select 
                f.idFilme as idFilme
            from
                Filmes as f, Produtora as p
            where
                f.idProdutora = 1) as s1
            where
                g.idFilme = s1.idFilme) as s2 ON idGenero = s2.genero;
*/
-- ---------------------------------------------------------------------------------------------
-- (g) Exemplos de criação de de 3 visões (Views). Inclua também exemplos de como usar cada uma das visões;
/*
        -- Mostra todos dos telefones com o nome de cada cliente
        create view Telefones_Cliente as select c.Nome, t.Telefone from Telefones as t join Cliente as c;

        -- Mostra  a mensalidade de cada cliente
        create view Mensalidade_Cliente as select c.Nome, a.Mensalidade from Cliente as c inner join Assinatura as a;

        -- Mostra o genero de cada filme
        create view Filmes_Genero as select f.Titulo, g.Descricao from Filmes as f inner join Genero as g;
*/
-- ---------------------------------------------------------------------------------------------
-- (h) Exemplos de criação de usuários (pelo menos 2), concessão (GRANT) e revocação (REVOKE) de permissão de acesso;
/*
        CREATE USER 'luciano'@'localhost' IDENTIFIED BY '0000';
        CREATE USER 'carlos'@'localhost' IDENTIFIED BY '0001';
        CREATE USER 'matheus'@'localhost' IDENTIFIED BY '0002';
        CREATE USER 'pedro'@'localhost' IDENTIFIED BY '0003';    

        GRANT ALL ON Locadora TO 'luciano'@'localhost'; --ADM 
        GRANT UPDATE (Titulo) ON Locadora.Filmes TO 'pedro'@'localhost';
        GRANT SELECT, INSERT, UPDATE ON Locadora.Cliente TO 'matheus'@'localhost';
        GRANT DELETE ON Locadora.Cliente TO 'carlos'@'localhost';

        REVOKE UPDATE (Titulo) ON Locadora.Filmes FROM 'pedro'@'localhost';
        REVOKE SELECT, INSERT, UPDATE ON Locadora.Cliente FROM 'matheus'@'localhost';
        REVOKE DELETE ON Locadora.Cliente FROM 'carlos'@'localhost';
*/
-- ---------------------------------------------------------------------------------------------
-- (i) Exemplos de 3 procedimentos/funções, com e sem parâmetros, de entrada e de saída,
-- contendo alguns comandos tais como IF, CASE WHEN, WHILE, declaração de
-- variáveis e funções prontas. Inclua exemplos como executar esses
-- procedimentos/funções;

        -- 1) Usada para gerar promoção para clientes que visualizaram uma determinada quantidade de filmes.
        -- CALL Promocao (100);   
        /*
        DELIMITER // 
        CREATE PROCEDURE Promocao(IN numero_de_filmes INT)
        BEGIN

        DECLARE done INT DEFAULT FALSE;

            DECLARE cont INT;
            DECLARE cpf INT;  
             
            DECLARE historico_aux CURSOR FOR -- Clia tabela para consulta
                select h.cpfCliente, Count(h.cpfCliente) as cont 
                from Historico AS h 
                group by h.cpfCliente;
         
            DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

            OPEN historico_aux;
            read_loop: LOOP
                FETCH historico_aux INTO cpf, cont; 
            
                IF done THEN
                    LEAVE read_loop;
                END IF;
            
                IF cont >= numero_de_filmes THEN -- Verifica se o numero de filmes é maior ou não. Se sim, aplica desconto.
                    UPDATE Assinatura SET Mensalidade = Mensalidade / 1.5 where cpf = cpfCliente;
                END IF;
            END LOOP;

            CLOSE historico_aux;
         
        END // 
        DELIMITER ;
        */

	-- 2) Mostra assinantes cadastrados no mes corrente
        -- call assinatesMes;
        /*
        DELIMITER // 
        CREATE PROCEDURE assinatesMes()
        BEGIN
           SELECT CASE EXTRACT(MONTH FROM Data_Assinatura) 
                     WHEN 01 THEN 'JAN'
                     WHEN 02 THEN 'FEV'
                     WHEN 03 THEN 'MAR'
                     WHEN 04 THEN 'ABR'
                     WHEN 05 THEN 'MAI'
                     WHEN 06 THEN 'JUN'
                     WHEN 07 THEN 'JUL'
                     WHEN 08 THEN 'AGO'
                     WHEN 09 THEN 'SET'
                     WHEN 10 THEN 'OUT'
                     WHEN 11 THEN 'NOV'
                     WHEN 12 THEN 'DEZ'
                  END AS mes, GROUP_CONCAT(Nome) AS funcionarios
            FROM Assinatura inner join Clientes
            GROUP BY mes;
        END // 
        DELIMITER ; 
        */

        -- 3) Devolve o valor da soma de todas as assinaturas
        -- call totalPorMes(@total);
        -- Select @total as Total_Assin;
        /*
        DELIMITER // 
        CREATE PROCEDURE totalPorMes(out total FLOAT)
        BEGIN
           select sum(Mensalidade) into total from Assinatura;
        END // 
        DELIMITER ; 
        */
-- ---------------------------------------------------------------------------------------------
-- (j) Exemplos de 3 triggers, um para cada evento (inserção, alteração e exclusão).
        -- 1)Verifica se o tipo de pagamento é valido, aceitando somente 'c' ou 'd'.
        /*
        DELIMITER $$
        CREATE TRIGGER before_Forma_de_Pagamento_insert
        BEFORE UPDATE ON Forma_de_Pagamento FOR EACH ROW
        BEGIN
            IF (NEW.Tipo_de_Pagamento = 'C') then
                set new.Tipo_de_Pagamento = 'c';
            ELSEIF (NEW.Tipo_de_Pagamento = 'D') THEN
                set NEW.Tipo_de_Pagamento = 'd';
            ELSEIF (NEW.Tipo_de_Pagamento != 'c') and (NEW.Tipo_de_Pagamento != 'd') THEN  
                SIGNAL SQLSTATE '45000' set message_text = 'Tipo de pagamento errado, somente c ou d';  
           END IF;
        END $$
        DELIMITER ;
        */

	-- 2) Verifica se o numero maximo de telefones para ja foi exedido
        /*
        DELIMITER $$
        CREATE TRIGGER before_insert_Telefone
        BEFORE INSERT ON Telefones FOR EACH ROW
        BEGIN
           DECLARE qtdTel INT;

           SELECT COUNT(cpfCliente)
           FROM Telefones
           WHERE cpfCliente = new.cpfCliente INTO qtdTel;	
            
           IF (qtdTel = 4) THEN
              SIGNAL SQLSTATE '45000' SET message_text = 'Cliente excede o número máximo de telefones.';
           END IF;
        END;
        $$
        DELIMITER ;
        */

        -- 3) Deleta Cartão ou debito após deletear a forma de pagamento.
        /*
        DELIMITER $$
        CREATE TRIGGER after_delete_Forma_de_Pagamento
        AFTER DELETE ON Forma_de_Pagamento FOR EACH ROW
        BEGIN
            DECLARE idForma INT; 
            DELETE FROM Cartao_de_credito WHERE idForma_de_Pagamento = Forma_de_Pagamento.idForma_de_Pagamento;
            DELETE FROM Debito_em_Conta WHERE idForma_de_Pagamento = Forma_de_Pagamento.idForma_de_Pagamento;
        END;
        $$
        DELIMITER ; 
        */

