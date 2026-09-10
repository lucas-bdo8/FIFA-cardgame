import os
from PIL import Image

LARGURA = 1752
ALTURA = 2336

pasta = os.path.dirname(os.path.abspath(__file__))

extensoes = (
    ".jpg",
    ".jpeg",
    ".png",
    ".webp",
    ".bmp",
    ".tiff"
)

arquivos = []

for arquivo in os.listdir(pasta):
    caminho = os.path.join(pasta, arquivo)

    if not os.path.isfile(caminho):
        continue

    if not arquivo.lower().endswith(extensoes):
        continue

    nome = os.path.splitext(arquivo)[0].lower()

    if nome == "coach":
        continue

    if nome.isdigit() and 1 <= int(nome) <= 26:
        continue

    arquivos.append(caminho)

arquivos.sort(key=os.path.getmtime)

if not arquivos:
    print("Nenhuma imagem encontrada na pasta.")
    input("Pressione ENTER para sair...")
    exit()

i = 1

for arquivo in arquivos:

    print(f"Processando: {os.path.basename(arquivo)}")

    try:
        imagem = Image.open(arquivo)
        imagem = imagem.convert("RGB")

        largura, altura = imagem.size
        proporcao = 3 / 4

        if largura / altura > proporcao:

            nova_largura = int(altura * proporcao)
            esquerda = (largura - nova_largura) // 2

            imagem = imagem.crop((
                esquerda,
                0,
                esquerda + nova_largura,
                altura
            ))

        else:

            nova_altura = int(largura / proporcao)
            topo = (altura - nova_altura) // 2

            imagem = imagem.crop((
                0,
                topo,
                largura,
                topo + nova_altura
            ))

        imagem = imagem.resize(
            (LARGURA, ALTURA),
            Image.Resampling.LANCZOS
        )

        if i <= 26:

            nome = f"{i}.png"
            caminho_saida = os.path.join(pasta, nome)

            imagem.save(
                caminho_saida,
                "PNG"
            )

            print(f"Salvo: {nome}")

            i += 1

        else:

            nome = "Coach.jpg"
            caminho_saida = os.path.join(pasta, nome)

            imagem.save(
                caminho_saida,
                "JPEG",
                quality=95
            )

            print(f"Salvo: {nome}")

            i = 1

        imagem.close()

        os.remove(arquivo)
        print(f"Original removido: {os.path.basename(arquivo)}")

    except Exception as erro:

        print(f"ERRO: {erro}")

print()
print("CONVERSAO FINALIZADA!")
input("Pressione ENTER para sair...")