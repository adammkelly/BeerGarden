package api

import (
	"fmt"
	"log"
	"net/http"

	"github.com/adammkelly/BeerGarden/api/endpoints"
	"github.com/gorilla/mux"
)

// App has router and db instances
type App struct {
	Router *mux.Router
}

var a App

func homeLink(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Welcome home!")
}

// Get wraps the router for GET method
func (a *App) Get(path string, f func(w http.ResponseWriter, r *http.Request)) {
	a.Router.HandleFunc(path, f).Methods("GET")
}

// Post wraps the router for POST method
func (a *App) Post(path string, f func(w http.ResponseWriter, r *http.Request)) {
	a.Router.HandleFunc(path, f).Methods("POST")
}

// Put wraps the router for PUT method
func (a *App) Put(path string, f func(w http.ResponseWriter, r *http.Request)) {
	a.Router.HandleFunc(path, f).Methods("PUT")
}

// Delete wraps the router for DELETE method
func (a *App) Delete(path string, f func(w http.ResponseWriter, r *http.Request)) {
	a.Router.HandleFunc(path, f).Methods("DELETE")
}

// Run the app on it's router
func (a *App) Run(host string) {
	log.Fatal(http.ListenAndServe(host, a.Router))
}

type RequestHandlerFunction func(w http.ResponseWriter, r *http.Request, vars map[string]string)

func (a *App) handleRequest(handler RequestHandlerFunction) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		handler(w, r, mux.Vars(r))
	}
}

func Run() {
	a.Router = mux.NewRouter()
	a.Get("/", homeLink)
	a.Get("/beers", a.handleRequest(endpoints.GetBeers))
	a.Run(":8080")
}

func checkErr(err error) {
	if err != nil {
		panic(err)
	}
}
