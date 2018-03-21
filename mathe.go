package main

import "fmt"
import "time"
import "math/rand"

const ANZAHL=5

func main() {
    fmt.Printf(" +++++ Berechne +++++\n")
    for i:=0; i<ANZAHL; i++ {
        rand.Seed(time.Now().UTC().UnixNano()+ int64(i))
        x := rand.Intn(1000)
        y := rand.Intn(10)
        z := rand.Intn(1000)
        fmt.Printf("%d × %d + %d × %d\n", x, y, y, z)
    }
    fmt.Printf(" +++++ Primzahl-Zerlegung / Prüfe Teilbarkeit 2,3,5 +++++\n")
    for i:=0; i<ANZAHL; i++ {
        rand.Seed(time.Now().UTC().UnixNano()+ int64(i))
        x := rand.Intn(1000)
        fmt.Printf("%d\n", x)
    }
    fmt.Printf(" +++++ Berechne +++++\n")
    for i:=0; i<ANZAHL; i++ {
        rand.Seed(time.Now().UTC().UnixNano()+ int64(i))
        x := rand.Intn(9) + 1
        y := rand.Intn(x * 10)
        x0 := x*10 - y
        x1 := y
        x2 := rand.Intn(1000)
        fmt.Printf("%d + %d + %d\n",x0,x2, x1)
    }
    fmt.Printf(" +++++ Berechne +++++\n")
    for i:=0; i<ANZAHL; i++ {
        rand.Seed(time.Now().UTC().UnixNano()+ int64(i))
        x := rand.Intn(99) + 1
        y := rand.Intn(10)
        z := rand.Intn(10)
        fmt.Printf("%d × (%d + %d)\n", x, y, z)
    }
    fmt.Printf(" +++++ Berechne +++++\n")
    for i:=0; i<ANZAHL; i++ {
        rand.Seed(time.Now().UTC().UnixNano()+ int64(i))
        x := rand.Intn(100)
        y := rand.Intn(10)
        z := rand.Intn(10)
        fmt.Printf("%d + (%d × %d)\n", x, y, z)
    }
    fmt.Printf(" +++++ Berechne +++++\n")
    for i:=0; i<ANZAHL; i++ {
        rand.Seed(time.Now().UTC().UnixNano()+ int64(i))
        x := rand.Intn(ANZAHL) + 1
        y := rand.Intn(10) + 1
        fmt.Printf("%d × %d\n", x, y)
    }
}

