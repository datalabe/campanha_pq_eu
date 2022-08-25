#regressao logistica
log <- glm(Abordado ~ Escolaridade + Gênero + Raça + FaixaEtária + Favela  + Capital,
           data=final, family = binomial)

#transformando para fator
table(final$Abordado)
contrasts(final$Abordado)
final$Abordado <- as.factor(final$Abordado)

table(final$Escolaridade)
contrasts(final$Escolaridade)
final$Escolaridade <- as.factor(final$Escolaridade)

table(final$Gênero)
contrasts(final$Gênero)
final$Gênero <- as.factor(final$Gênero)
final$Gênero <- factor(final$Gênero, levels = c("Feminino", "Masculino",
                                                "Bissexual","Gay","Gênero fluído",
                                                "Não - binário","Panssexual","Prefiro não declarar",
                                                "Queer"))

table(final$Raça)
contrasts(final$Raça)
final$Raça <- as.factor(final$Raça)
final$Raça <- factor(final$Raça, levels = c("Branca","Negra","Amarela","Indígena"))

table(final$Favela)
contrasts(final$Favela)
final$Favela <- as.factor(final$Favela)

table(final$Capital)
contrasts(final$Capital)
final$Capital <- as.factor(final$Capital)


#resultados
summary(log)

exp(coef(log))
