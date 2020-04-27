package endpoints

import (
	"fmt"
	"net/http"
)

type beer struct {
	UUID        string  `json:"UUID"`
	Title       string  `json:"Title"`
	Description string  `json:"Description"`
	Percent     float32 `json:"Percent"`
	Size        string  `json:"Size"`
}

type Beers []beer

var beers = Beers{}

func GetBeers(w http.ResponseWriter, r *http.Request, vars map[string]string) {
	var allBeers = Beers{}
	query := getAllBeers()
	rows := GetQuery(query)
	for rows.Next() {
		var uuid string
		var title string
		var description string
		var percent float32
		var size string
		err := rows.Scan(&uuid, &title, &description, &size, &percent)
		checkErr(err)
		fmt.Printf("Got beer: %s", title)
		allBeers = append(
			allBeers,
			beer{
				UUID:        uuid,
				Title:       title,
				Description: description,
				Percent:     percent,
				Size:        size,
			},
		)
	}
	respondJSON(w, http.StatusOK, allBeers)
}

func GetBeersRandom(w http.ResponseWriter, r *http.Request, vars map[string]string) {
	query := getRandomBeer()
	rows := GetQuery(query)
	var uuid string
	var title string
	var description string
	var percent float32
	var size string
	for rows.Next() {
		err := rows.Scan(&uuid, &title, &description, &size, &percent)
		checkErr(err)
	}
	fmt.Printf("Got beer: %s", title)
	var m map[string]beer
	m = make(map[string]beer)
	m["response"] = beer{
		UUID:        uuid,
		Title:       title,
		Description: description,
		Percent:     percent,
		Size:        size,
	}
	respondJSON(w, http.StatusOK, m)
}

func getAllBeers() (query string) {
	var q = "SELECT * FROM beers"
	return q
}

func getRandomBeer() (query string) {
	var q = "SELECT * FROM beers ORDER BY RANDOM() LIMIT 1"
	return q
}

func checkErr(err error) {
	if err != nil {
		panic(err)
	}
}
