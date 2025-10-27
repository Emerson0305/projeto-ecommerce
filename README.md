create database ECOMMERCE;

use ECOMMERCE;

show tables;



-- Criando a tabela Cliente.

create table clients (

&nbsp;	idClients int primary key auto\_increment,

&nbsp;	Pname varchar(45) not null,

&nbsp;	Minit char(3),

&nbsp;	Lname varchar(45),

&nbsp;   Accounty\_type enum ('Pessoa Fisica','Pessoa Jurídica') default 'Pessoa Fisica' not null,

&nbsp;   CPF char(11) not null,

&nbsp;   Date\_of\_brirth date,

&nbsp;   Address varchar(45),

&nbsp;   constraint unique\_cpf\_client unique (CPF)

&nbsp;   );

&nbsp;   

-- Criando a tabela Produto.

create table Product (

&nbsp;	idProduct int primary key not null,

&nbsp;   Pname varchar(45) not null,

&nbsp;   Category enum ('Eletrônico','Vestimenta','Brinquedo','Alimento','Móveis') not null,

&nbsp;   Descriptionp varchar(45),

&nbsp;   Value\_producty float not null,

&nbsp;   Assessment float default 0,

&nbsp;   Size varchar(45) ,

&nbsp;   Classification varchar(45)

&nbsp;   );

&nbsp;   

-- Criando a tabela Pedido.

create table Orders(

&nbsp;	idOrders int primary key not null,

&nbsp;   idOrdersClients int,

&nbsp;   OrderStatus enum ('Cancelado','Confirmado','Em Processamento') default 'Em Processamento' not null,

&nbsp;   StatusDelivery enum ('Em andamento','Entregue','Aguardando Retirada') default 'Aguardando Retirada' not null,

&nbsp;   DescriptionOrder varchar(45),

&nbsp;   TaxDelivery float default 10,

&nbsp;   OrderNumber int not null,

&nbsp;   Codetracking char(10) not null,

&nbsp;   constraint fk\_Ordersclient foreign key (idOrdersClients) references clients (idclients)

);

&nbsp;   

-- Criando a tabela Pagamento.

create table Payment(

&nbsp;	idPayment int primary key not null,

&nbsp;   idOrderspay int,

&nbsp;   idClientspay int,

&nbsp;   typePayment enum ('Pix','Cartão de crédito','Cartão de débito','Boleto','Dinheiro') not null,

&nbsp;   statusPayment enum ('Aprovado','Pendente','Cancelado') default 'Pendente' not null,

&nbsp;   limitis float,

&nbsp;   valuesPayment float not null,

&nbsp;	check (

&nbsp;   (statusPayment = 'Aprovado' and limitis > 0) or

&nbsp;	(statusPayment = 'Cancelado' and limitis = 0) or 

&nbsp;   (statusPayment= 'Pendente')

&nbsp;	),

&nbsp;   constraint fk\_paymentOrders foreign key (idOrderspay) references Orders (idOrders),

&nbsp;   constraint fk\_paymentClients foreign key(idClientspay) references Clients (idClients)

&nbsp;   );

&nbsp;   

-- Criando a tabela estoque.

alter table Stocks 

modify column Location varchar (255);

select \* from stocks;

create table Stocks(

&nbsp;	idStocks int primary key not null,

&nbsp;	Location varchar(45) not null,

&nbsp;   Quantity int default 0

&nbsp;   );

&nbsp;   

-- Criando a tabela Fornecedor.

select \* from supplier;

desc Supplier;

create table supplier(

&nbsp;	idSupplier int primary key not null,

&nbsp;   SocialName varchar(45) not null,

&nbsp;   CNPJ char(15) not null,

&nbsp;   Contact char(11) not null,

&nbsp;   email varchar(45),

&nbsp;   Address varchar(45),

&nbsp;   constraint unique\_supplier\_cnpj unique(CNPJ)

&nbsp;   );

&nbsp;   

-- Criando a tabela Vendedor.

desc seller;

create table Seller(

&nbsp;	idSeller int primary key not null,

&nbsp;   SocialName varchar(255) not null,

&nbsp;   Location varchar(255),

&nbsp;   CPF\_CNPJ char(11) not null,

&nbsp;   Contact char(11) ,

&nbsp;   typePerson enum('Pessoa Física','Pessoa Jurídica') default 'Pessoa Fisica' not null,

&nbsp;   constraint unique\_seller\_cpf\_cnpj unique (CPF\_CNPJ)

&nbsp;   );

&nbsp;   

-- Criando a tabela Fornecedor\_Vendedor.

desc supplier\_seller;

create table Supplier\_Seller(

&nbsp;	idSupler\_Supplier int,

&nbsp;   idSupler\_Seller int,

&nbsp;   date\_parceria date,

&nbsp;   primary key (idSupler\_Supplier,idSupler\_Seller),

&nbsp;   constraint fk\_Supplier\_Seller\_Supplier foreign key (idSupler\_Supplier) references Supplier(idSupplier),

&nbsp;   constraint fk\_Supplier\_Seller\_Seller foreign key (idSupler\_Seller) references Seller (idSeller)

&nbsp;   );

&nbsp;   

-- Criando a tabela Produtos vendedor.

desc product\_seller;

create table Product\_Seller(

&nbsp;   idPproduct int,

&nbsp;	idPseller int,

&nbsp;   ProdQuantity int default 1,

&nbsp;   primary key (idPproduct,idPseller),

&nbsp;	constraint fk\_product\_product foreign key (idPproduct) references Product (idProduct),

&nbsp;   constraint fk\_product\_seller foreign key(idPseller) references Seller(idSeller)

);



-- Criando a tabela Produto Pedido.

desc product\_orders;

create table Product\_Orders(

&nbsp;	idPpproduct int,

&nbsp;   idPporders int,

&nbsp;   poQuantity int default 1,

&nbsp;   poStatus enum('Disponível','Sem estoque') default 'Disponível',

&nbsp;   primary key(idPpproduct,idPporders),

&nbsp;   constraint fk\_product\_Order\_p foreign key (idPpproduct) references Product (idProduct),

&nbsp;   constraint fk\_product\_Orders\_o foreign key (idPporders) references Orders (idOrders)

&nbsp;   );

&nbsp;   

-- Criando a tabela Produto em estoque.

desc product\_storage;

create table Product\_storage(

&nbsp;	idStorage\_product int,

&nbsp;   idStorage\_stocks int,

&nbsp;   storage\_location varchar(255) not null,

&nbsp;   primary key (idStorage\_product,idStorage\_stocks),

&nbsp;   constraint fk\_Storage\_product foreign key (idStorage\_product) references Product(idProduct),

&nbsp;   constraint fk\_Starage\_stocks foreign key (idStorage\_stocks) references Stocks(idStocks)

&nbsp;   );



-- Criando a tabela Produto fornecedor.

desc product\_supplier;

create table Product\_supplier(

&nbsp;	idPfProduct int,

&nbsp;   idPfSupplier int,

&nbsp;   pfQuantity int not null,

&nbsp;   primary key(idPfProduct,idPfSupplier),

&nbsp;	constraint fk\_ProductSupplier\_product foreign key(idPfProduct) references Product(idProduct),

&nbsp;   constraint fk\_ProductSupplier\_supplier foreign key(idPfSupplier) references Supplier(idSupplier)

&nbsp;   );

&nbsp;   



