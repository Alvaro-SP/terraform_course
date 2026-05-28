# Paso 2 — Modular (3 módulos planos)

## Qué demuestra

El mismo despliegue del paso 1, pero separado en **3 módulos por capa**:
`network`, `compute`, `data`. El root los orquesta.

Demuestra:
- Variables que **bajan** del root al módulo.
- Outputs que **suben** del módulo al root.
- Dependencias **implícitas** entre módulos (compute depende de network porque usa `module.network.vpc_id`).

## Cómo ejecutar

```bash
terraform init
terraform plan      # observa los 3 bloques module en el plan
terraform apply -auto-approve
cat infra-summary.txt
```

## Bonus: ver el grafo de dependencias

```bash
terraform graph | dot -Tpng > graph.png  # requiere graphviz
# o más simple:
terraform graph
```

## Qué decir en clase

> "Abran `main.tf` del root. Antes había 80 líneas, ahora hay 30. Las otras
> 50 líneas se fueron a los módulos. Pero **el comportamiento es idéntico**."

> "Fíjense en este detalle clave en compute:
> `vpc_id = module.network.vpc_id`
> Esa línea le dice a Terraform: 'compute necesita el output de network'.
> Eso crea una dependencia automática. Network se crea PRIMERO, compute después."

## Transición al paso 3

> "Pero ahora imaginen que tengo 5 equipos. Cada uno va a llamar a estos
> 3 módulos uno por uno. Es repetitivo. ¿Y si encapsulamos los 3 en uno
> solo? Eso es paso 3."
