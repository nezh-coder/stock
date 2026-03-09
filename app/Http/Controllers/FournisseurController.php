<?php

namespace App\Http\Controllers;
use App\Models\Fournisseur;
use Illuminate\Http\Request;

class FournisseurController extends Controller
{
     public function index(Request $request)
    {
        $query = Fournisseur::query();

        // Search by name
        if ($request->has('search') && !empty($request->search)) {
            $query->where('name', 'like', '%' . $request->search . '%');
        }

        // Filter by credit status
        if ($request->has('credit_status') && !empty($request->credit_status)) {
            switch ($request->credit_status) {
                case 'no_credit':
                    $query->where('credit', 0);
                    break;
                case 'has_credit':
                    $query->where('credit', '>', 0)->where('credit', '<=', 1000);
                    break;
                case 'high_credit':
                    $query->where('credit', '>', 1000);
                    break;
            }
        }

        $fournisseurs = $query->paginate(15);
        return view('fournisseurs.index', compact('fournisseurs'));
    }
     public function create()
    {
         return view('Fournisseurs.create');
    }
     public function store(Request $request)
    { 
        $request->validate([
              'name' => 'required|string',
            'tel' => 'required|string',
            'email' => 'nullable|email',
            'adresse' => 'nullable|string',
           'ice' => 'nullable|string',

        ]);

        Fournisseur::create([
            'name' => $request->name,
            'tel' => $request->tel,
            'email' => $request->email,
            'adresse' => $request->adresse,
            'ice' => $request->ice, 
        ]);
       ///  dd($request->all()); // ✅ test if the request is received
        return redirect()->route('fournisseurs.index')->with('success', 'Fournisseur created successfully!');
    
    }
     public function update(Request $request, string $id)
    {
        $request->validate([
            'name' => 'required|unique:products,name,' . $id,
            'adresse' => 'nullable|string',
            'email' => 'nullable|email',
            'tel' => 'required|string',
            'ice' => 'nullable|string',
        ]);

        $fournisseur = Fournisseur::findOrFail($id);
        
        $fournisseur->update([
            'name' => $request->name,
            'adresse' => $request->adresse,
            'email' => $request->email,
            'tel' => $request->tel,
            'ice' => $request->ice,
        ]);
       
        return redirect()->route('fournisseurs.index')->with('success', 'Fournisseur mis à jour avec succès!');
    }
     public function show( string $id)
    {
         $fournisseur = Fournisseur::findOrFail($id);
        return view('Fournisseurs.show', compact('fournisseur'));
         
    }
    public function edit(string $id)
    {
        $fournisseur = Fournisseur::findOrFail($id);
        return view('Fournisseurs.edit', compact('fournisseur'));
    }

     public function delete()
    {
         return view('Fournisseurs.create');
    }

     /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $fournisseur = Fournisseur::findOrFail($id);
        $fournisseur->delete();

        return redirect()->route('fournisseurs.index')->with('success', 'Fournisseur supprimé avec succès!');
    }
}
