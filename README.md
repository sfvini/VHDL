# Guia Rápido de VHDL: Conceitos e Sintaxe

Este repositório serve como uma referência prática para o desenvolvimento em **VHDL** (*VHSIC Hardware Description Language*), cobrindo bibliotecas, tipos de dados, estruturas de código e sintaxe básica.

---

## 1. Bibliotecas Comuns (`libraries`)

As bibliotecas estendem a linguagem VHDL para incluir novos tipos de dados, funções e operadores aritméticos/lógicos. Elas devem ser declaradas sempre no topo do arquivo.

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL; -- Define os tipos STD_LOGIC e STD_LOGIC_VECTOR (Padrão)
use IEEE.NUMERIC_STD.ALL;    -- Habilita operações aritméticas usando tipos SIGNED e UNSIGNED
```

## 2. Estrutura Básica de um Arquivo

Um código VHDL é rigidamente dividido em duas partes principais: a **Entity** (a interface física/pinos) e a **Architecture** (o comportamento interno).

### A. Entity (Interface/Pinos)

Define o nome do componente e a direção/tipo de suas portas de entrada e saída.

```vhdl
entity NomeDoCircuito is
    port (
        clk    : in  std_logic;                    -- Entrada de 1 bit
        reset  : in  std_logic;                    -- Entrada de 1 bit
        dado_in: in  std_logic_vector(7 downto 0); -- Barramento de entrada de 8 bits
        q_out  : out std_logic_vector(7 downto 0)  -- Barramento de saída de 8 bits
    );
end NomeDoCircuito;
```

### B. Architecture (Comportamento/Lógica)

Define como o circuito funciona internamente. Pode conter lógica concorrente ou processos sequenciais.

```vhdl
architecture behavior of NomeDoCircuito is
    -- Área de declaração de Sinais Internos (fios/barramentos internos)
    signal fio_interno : std_logic_vector(7 downto 0);
begin
    -- O código lógico/funcional entra aqui
end behavior;
```

## 3. Principais Tipos de Dados

| Tipo | Descrição | Exemplo de Atribuição |
| --- | --- | --- |
| std_logic | Um bit digital. Pode assumir valores como '0', '1', 'Z' (alta impedância) ou 'X' (desconhecido). | sinal <= '1'; |
| std_logic_vector | Um vetor ou barramento de bits. | bus <= "10101100"; |
| integer | Número inteiro de 32 bits (muito comum em contadores e constantes). |contador <= 42; |
| unsigned | Vetor de bits interpretado como número positivo sem sinal (requer numeric_std). | num <= unsigned(bus); |
| signed | Vetor de bits interpretado em Complemento de 2 (requer numeric_std). | num <= signed(bus); |

> **Nota sobre sintaxe:** Caracteres únicos (bits simples) usam aspas simples ('0'). Vetores de texto/bits usam aspas duplas ("1010").

## 4. Sintaxe e Operadores Essenciais

### Atribuições

* Sinais (signal): Representam conexões físicas (fios). Usam o operador <=.
* Variáveis (variable): Existem **apenas dentro de processos** (process) e atualizam seu valor instantaneamente. Usam o operador :=.

#### Operadores Lógicos e Aritméticos

* Lógicos: and, or, nand, nor, xor, xnor, not.
* Aritméticos: +, -, *, / (**requer numeric_std** para operações com vetores).
* Concatenação: & (junta dois vetores ou bits). Ex: novo_vetor <= bit_A & vetor_B;

## 5. Estruturas de Fluxo de Controle

O VHDL opera majoritariamente em paralelo (concorrente). No entanto, dentro de blocos process, a execução lógica é interpretada de forma sequencial.

### Processos Sequenciais (process)
Usados para lógica combinacional complexa ou circuitos sequenciais (síncronos com o clock).

```vhdl
process(clk, reset) -- Lista de Sensibilidade
begin
    if reset = '1' then
        q_out <= (others => '0'); -- Zera todos os bits do vetor automaticamente
    elsif rising_edge(clk) then   -- Detecção de borda de subida do clock
        if enable = '1' then
            q_out <= dado_in;
        end if;
    end if;
end process;
```
