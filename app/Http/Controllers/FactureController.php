<?php

namespace App\Http\Controllers;

use App\Models\Facture;
use App\Models\Entreprise;
use App\Models\Client;
use Illuminate\Http\Request;
use Barryvdh\DomPDF\Facade\Pdf;

class FactureController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = Facture::with(['client', 'bonLivraison']);

        // Search by numero_facture
        if ($request->has('search') && !empty($request->search)) {
            $query->where('numero_facture', 'like', '%' . $request->search . '%');
        }

        // Filter by status
        if ($request->has('status') && !empty($request->status)) {
            $query->where('status', $request->status);
        }

        // Filter by date range
        if ($request->has('date_from') && !empty($request->date_from)) {
            $query->whereDate('date_facture', '>=', $request->date_from);
        }
        if ($request->has('date_to') && !empty($request->date_to)) {
            $query->whereDate('date_facture', '<=', $request->date_to);
        }

        $factures = $query->paginate(15);
        return view('factures.index', compact('factures'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $clients = \App\Models\Client::all();
        $bonLivraisons = \App\Models\BonLivraison::all();
        return view('factures.create', compact('clients', 'bonLivraisons'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'numero_facture' => 'required|string|unique:factures',
            'client_id' => 'required|exists:clients,id',
            'bon_livraison_id' => 'nullable|exists:bon_livraisons,id',
            'date_facture' => 'required|date',
            'date_echeance' => 'required|date|after_or_equal:date_facture',
            'total_ht' => 'required|numeric|min:0',
            'tva' => 'required|numeric|min:0',
            'total_ttc' => 'required|numeric|min:0',
            'status' => 'required|in:non_payee,partiellement_paye,payee,annulee',
        ]);

        Facture::create($request->all());

        return redirect()->route('factures.index')->with('success', 'Facture créée avec succès.');
    }

    /**
     * Display the specified resource.
     */
    public function show(Facture $facture)
    {
        $facture->load('client', 'bonLivraison', 'products');
        return view('factures.show', compact('facture'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Facture $facture)
    {
        $clients = \App\Models\User::all();
        $bonLivraisons = \App\Models\BonLivraison::all();
        return view('factures.edit', compact('facture', 'clients', 'bonLivraisons'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Facture $facture)
    {
        $request->validate([
            'numero_facture' => 'required|string|unique:factures,numero_facture,' . $facture->id,
            'client_id' => 'required|exists:users,id',
            'bon_livraison_id' => 'nullable|exists:bon_livraisons,id',
            'date_facture' => 'required|date',
            'date_echeance' => 'required|date|after_or_equal:date_facture',
            'total_ht' => 'required|numeric|min:0',
            'tva' => 'required|numeric|min:0',
            'total_ttc' => 'required|numeric|min:0',
            'status' => 'required|in:non_payee,partiellement_paye,payee,annulee',
        ]);

        $facture->update($request->all());

        return redirect()->route('factures.index')->with('success', 'Facture mise à jour avec succès.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Facture $facture)
    {
        $facture->delete();

        return redirect()->route('factures.index')->with('success', 'Facture supprimée avec succès.');
    }

    public function pdf(Facture $facture)
    {
        
            $facture->load(['bonLivraison', 'products']);
             // Charger le client avec le devis
            $facture->load('client');
            $client = $facture->client;
             $entreprise = Entreprise::first();
            $pdf = Pdf::loadView('factures.pdf.pdf', compact('facture', 'entreprise', 'client'))
                ->setPaper('A4');

            return $pdf->stream('facture'.$facture->id.'.pdf');
        
    // stream = afficher / print
    // download = télécharger
    }
}
