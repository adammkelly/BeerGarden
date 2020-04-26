package endpoints

import (
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
	//query, args := getAllBeers()
	//db := connectToDatabase()
	//rows, err := db.Query(query, args)
	//checkErr(err)
	//for rows.Next() {
	var uuid string = "1"
	var title string = "Adam"
	var description string = "DEsc"
	var percent float32 = 5.0
	var size string = "600ml"
	//err := rows.Scan(&uuid, &title, &description, &percent, &size)
	//checkErr(err)
	/*
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
	*/
	allBeers = append(
		allBeers,
		beer{
			UUID:        uuid,
			Title:       title,
			Description: description,
			Percent:     percent,
			Size:        size,
		})
	//}
	respondJSON(w, http.StatusOK, allBeers)
}

func getAllBeers() (query string, args interface{}) {
	var q string = "SELECT * FROM beers"
	var a interface{}
	return q, a
}

func checkErr(err error) {
	if err != nil {
		panic(err)
	}
}
