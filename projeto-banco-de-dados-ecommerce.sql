create database ECOMMERCE;
use ECOMMERCE;
show tables;

-- Criando a tabela Cliente.
create table clients (
	idClients int primary key auto_increment,
	Pname varchar(45) not null,
	Minit char(3),
	Lname varchar(45),
    Accounty_type enum ('Pessoa Fisica','Pessoa Jurídica') default 'Pessoa Fisica' not null,
    CPF char(11) not null,
    Date_of_brirth date,
    Address varchar(45),
    constraint unique_cpf_client unique (CPF)
    );
    
-- Criando a tabela Produto.
create table Product (
	idProduct int primary key not null,
    Pname varchar(45) not null,
    Category enum ('Eletrônico','Vestimenta','Brinquedo','Alimento','Móveis') not null,
    Descriptionp varchar(45),
    Value_producty float not null,
    Assessment float default 0,
    Size varchar(45) ,
    Classification varchar(45)
    );
    
-- Criando a tabela Pedido.
create table Orders(
	idOrders int primary key not null,
    idOrdersClients int,
    OrderStatus enum ('Cancelado','Confirmado','Em Processamento') default 'Em Processamento' not null,
    StatusDelivery enum ('Em andamento','Entregue','Aguardando Retirada') default 'Aguardando Retirada' not null,
    DescriptionOrder varchar(45),
    TaxDelivery float default 10,
    OrderNumber int not null,
    Codetracking char(10) not null,
    constraint fk_Ordersclient foreign key (idOrdersClients) references clients (idclients)
);
    
-- Criando a tabela Pagamento.
create table Payment(
	idPayment int primary key not null,
    idOrderspay int,
    idClientspay int,
    typePayment enum ('Pix','Cartão de crédito','Cartão de débito','Boleto','Dinheiro') not null,
    statusPayment enum ('Aprovado','Pendente','Cancelado') default 'Pendente' not null,
    limitis float,
    valuesPayment float not null,
	check (
    (statusPayment = 'Aprovado' and limitis > 0) or
	(statusPayment = 'Cancelado' and limitis = 0) or 
    (statusPayment= 'Pendente')
	),
    constraint fk_paymentOrders foreign key (idOrderspay) references Orders (idOrders),
    constraint fk_paymentClients foreign key(idClientspay) references Clients (idClients)
    );
    
-- Criando a tabela estoque.
alter table Stocks 
modify column Location varchar (255);
select * from stocks;
create table Stocks(
	idStocks int primary key not null,
	Location varchar(45) not null,
    Quantity int default 0
    );
    
-- Criando a tabela Fornecedor.
select * from supplier;
desc Supplier;
create table supplier(
	idSupplier int primary key not null,
    SocialName varchar(45) not null,
    CNPJ char(15) not null,
    Contact char(11) not null,
    email varchar(45),
    Address varchar(45),
    constraint unique_supplier_cnpj unique(CNPJ)
    );
    
-- Criando a tabela Vendedor.
desc seller;
create table Seller(
	idSeller int primary key not null,
    SocialName varchar(255) not null,
    Location varchar(255),
    CPF_CNPJ char(11) not null,
    Contact char(11) ,
    typePerson enum('Pessoa Física','Pessoa Jurídica') default 'Pessoa Fisica' not null,
    constraint unique_seller_cpf_cnpj unique (CPF_CNPJ)
    );
    
-- Criando a tabela Fornecedor_Vendedor.
desc supplier_seller;
create table Supplier_Seller(
	idSupler_Supplier int,
    idSupler_Seller int,
    date_parceria date,
    primary key (idSupler_Supplier,idSupler_Seller),
    constraint fk_Supplier_Seller_Supplier foreign key (idSupler_Supplier) references Supplier(idSupplier),
    constraint fk_Supplier_Seller_Seller foreign key (idSupler_Seller) references Seller (idSeller)
    );
    
-- Criando a tabela Produtos vendedor.
desc product_seller;
create table Product_Seller(
    idPproduct int,
	idPseller int,
    ProdQuantity int default 1,
    primary key (idPproduct,idPseller),
	constraint fk_product_product foreign key (idPproduct) references Product (idProduct),
    constraint fk_product_seller foreign key(idPseller) references Seller(idSeller)
);

-- Criando a tabela Produto Pedido.
desc product_orders;
create table Product_Orders(
	idPpproduct int,
    idPporders int,
    poQuantity int default 1,
    poStatus enum('Disponível','Sem estoque') default 'Disponível',
    primary key(idPpproduct,idPporders),
    constraint fk_product_Order_p foreign key (idPpproduct) references Product (idProduct),
    constraint fk_product_Orders_o foreign key (idPporders) references Orders (idOrders)
    );
    
-- Criando a tabela Produto em estoque.
desc product_storage;
create table Product_storage(
	idStorage_product int,
    idStorage_stocks int,
    storage_location varchar(255) not null,
    primary key (idStorage_product,idStorage_stocks),
    constraint fk_Storage_product foreign key (idStorage_product) references Product(idProduct),
    constraint fk_Starage_stocks foreign key (idStorage_stocks) references Stocks(idStocks)
    );

-- Criando a tabela Produto fornecedor.
desc product_supplier;
create table Product_supplier(
	idPfProduct int,
    idPfSupplier int,
    pfQuantity int not null,
    primary key(idPfProduct,idPfSupplier),
	constraint fk_ProductSupplier_product foreign key(idPfProduct) references Product(idProduct),
    constraint fk_ProductSupplier_supplier foreign key(idPfSupplier) references Supplier(idSupplier)
    );
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


	
    
    

