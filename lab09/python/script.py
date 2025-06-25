#!/usr/bin/env python3

import time
import sys
import numpy as np
from PIL import Image, ImageOps
import matplotlib.pyplot as plt
import intel_jtag_uart

# === Configurações
IMG_PATH = "imagem.png"   # Caminho para a imagem de entrada
IMG_SIZE = (255, 255)     # Resolução da imagem original
PADDING = 1               # Padding de 1 pixel (automaticamente vira 256x256)
HEADER_TX = 0xAA
HEADER_RX = 0x55

# === Função para preparar a imagem
def preprocessar_imagem(caminho):
    img = Image.open(caminho).convert("L")  # escala de cinza
    img = img.resize(IMG_SIZE)
    img = ImageOps.expand(img, border=PADDING, fill=0)  # padding de 1px
    return np.array(img, dtype=np.uint8)

# === Enviar 1 byte via UART (bloqueante)
def uart_write_byte(ju, byte):
    while True:
        try:
            ju.write(bytes([byte]))
            break
        except Exception:
            time.sleep(0.001)  # espera e tenta de novo

# === Ler 1 byte da UART (bloqueante)
def uart_read_byte(ju):
    while True:
        data = ju.read()
        if data:
            return data[0]
        time.sleep(0.001)

# === Envia imagem completa via UART
def enviar_imagem(ju, img_array):
    altura, largura = img_array.shape

    uart_write_byte(ju, HEADER_TX)
    uart_write_byte(ju, altura)
    uart_write_byte(ju, largura)

    for byte in img_array.flatten():
        uart_write_byte(ju, byte)

# === Recebe imagem da UART (bloqueante)
def receber_imagem(ju, altura, largura):
    while True:
        header = uart_read_byte(ju)
        if header == HEADER_RX:
            break

    total = altura * largura
    buffer = bytearray()
    while len(buffer) < total:
        b = uart_read_byte(ju)
        buffer.append(b)

    return np.frombuffer(buffer, dtype=np.uint8).reshape((altura, largura))

# === Função principal
def main():
    try:
        ju = intel_jtag_uart.intel_jtag_uart()
    except Exception as e:
        print("Erro:", e)
        sys.exit(1)

    img_array = preprocessar_imagem(IMG_PATH)
    altura, largura = img_array.shape

    print(f"Enviando {altura}x{largura}")
    enviar_imagem(ju, img_array)

    print("Aguardando resposta da FPGA...")
    img_resultado = receber_imagem(ju, altura, largura)
    print("Imagem recebida")

    # Visualização lado a lado
    fig, axs = plt.subplots(1, 2, figsize=(10, 5))
    axs[0].imshow(img_array, cmap="gray")
    axs[0].set_title("Original (com padding)")
    axs[0].axis("off")

    axs[1].imshow(img_resultado, cmap="gray")
    axs[1].set_title("Recebida da FPGA")
    axs[1].axis("off")

    plt.show()

if __name__ == "__main__":
    main()
