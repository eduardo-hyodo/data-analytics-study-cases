# Instalar pacotes (se necessário)
install.packages("tidyverse")
install.packages("lubridate")

# Carregar pacotes
library(tidyverse)
library(lubridate)

# Definir diretório e carregar os dados
activity_data <- read_csv("dailyActivity_merged.csv")
sleep_data <- read_csv("sleepDay_merged.csv")

# Verificar estrutura dos dados
glimpse(activity_data)
summary(activity_data)

glimpse(sleep_data)
summary(sleep_data)

# Converter colunas de data para o formato correto
activity_data <- activity_data %>%
  mutate(ActivityDate = mdy(ActivityDate))

sleep_data <- sleep_data %>%
  mutate(SleepDay = mdy_hms(SleepDay)) %>%
  mutate(SleepDate = as.Date(SleepDay))

# Limpeza dos Dados
# Verificar valores únicos de IDs (quantas usuárias distintas)
n_distinct(activity_data$Id)
n_distinct(sleep_data$Id)

# Duplicatas em cada dataset
sum(duplicated(activity_data))
sum(duplicated(sleep_data))

# Remover duplicatas se existirem
activity_data <- activity_data %>% distinct()
sleep_data <- sleep_data %>% distinct()

# Verificar valores NA
colSums(is.na(activity_data))
colSums(is.na(sleep_data))

# Sem dados ausentes importatnes, assim nao precisei fazer o drop_na()
#activity_data <- activity_data %>% drop_na()
#sleep_data <- sleep_data %>% drop_na()

# Resumo das variáveis principais
summary(activity_data %>%
          select(TotalSteps, TotalDistance, Calories))

summary(sleep_data %>%
          select(TotalSleepRecords, TotalMinutesAsleep, TotalTimeInBed))
activity_data %>%
  summarise(
    mean_steps = mean(TotalSteps),
    median_steps = median(TotalSteps),
    sd_steps = sd(TotalSteps),
    mean_calories = mean(Calories),
    sd_calories = sd(Calories)
  )

sleep_data %>%
  summarise(
    mean_sleep = mean(TotalMinutesAsleep),
    median_sleep = median(TotalMinutesAsleep),
    sd_sleep = sd(TotalMinutesAsleep)
  )

ggplot(activity_data, aes(x = TotalSteps)) +
  geom_histogram(binwidth = 1000, fill = "skyblue", color = "black") +
  labs(title = "Distribuição de Passos Diários", x = "Total de Passos", y = "Frequência")

ggplot(sleep_data, aes(x = TotalMinutesAsleep)) +
  geom_histogram(binwidth = 30, fill = "purple", color = "black") +
  labs(title = "Distribuição de Minutos Dormidos", x = "Minutos de Sono", y = "Frequência")

ggplot(merged_data, aes(x = TotalMinutesAsleep, y = TotalSteps)) +
  geom_point(alpha = 0.6, color = "steelblue") +
  geom_smooth(method = "lm", se = FALSE, color = "darkred") +
  labs(title = "Correlação entre Sono e Passos", x = "Minutos de Sono", y = "Passos")

ggplot(activity_data, aes(x = TotalSteps, y = Calories)) +
  geom_point(alpha = 0.5, color = "darkgreen") +
  geom_smooth(method = "lm", se = FALSE, color = "orange") +
  labs(title = "Passos vs Calorias Queimadas", x = "Total de Passos", y = "Calorias")

sleep_data %>%
  summarise(
    avg_sleep_minutes = mean(TotalMinutesAsleep),
    avg_sleep_hours = mean(TotalMinutesAsleep) / 60
  )

cor(merged_data$TotalMinutesAsleep, merged_data$TotalSteps)

cor(activity_data$TotalSteps, activity_data$Calories)

activity_data %>%
  group_by(Id) %>%
  summarise(dias_registrados = n()) %>%
  arrange(desc(dias_registrados)) %>%
  summarise(
    avg_dias = mean(dias_registrados),
    max_dias = max(dias_registrados),
    min_dias = min(dias_registrados)
  )

sleep_data %>%
  summarise(
    avg_efficiency = mean(TotalMinutesAsleep / TotalTimeInBed)
  )


# Unir dados por ID e data
merged_data <- inner_join(activity_data, sleep_data, by = c("Id" = "Id", "ActivityDate" = "SleepDate"))

# Visualização: passos vs tempo de sono
ggplot(merged_data, aes(x = TotalMinutesAsleep, y = TotalSteps)) +
  geom_point(alpha = 0.6, color = "steelblue") +
  labs(title = "Passos vs Tempo de Sono",
       x = "Minutos Dormidos",
       y = "Total de Passos")
