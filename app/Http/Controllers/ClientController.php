<?php

namespace App\Http\Controllers;
use App\Models\Client;
use App\Imports\ClientsImport;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Facades\Excel;

class ClientController extends Controller
{
     public function index(Request $request)
    {
        $query = Client::query();

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

        $clients = $query->paginate(15);
        return view('clients.index', compact('clients'));
    }
     public function create()
    {
         return view('Clients.create');
    }
     public function store(Request $request)
    { 
        $request->validate([
            'name' => 'required|unique:products,name',
            'tel' => 'required|string',
            'email' => 'nullable|email',
            'adresse' => 'nullable|string',
           'ice' => 'nullable|string',

        ]);

        Client::create([
            'name' => $request->name,
            'tel' => $request->tel,
            'email' => $request->email,
            'adresse' => $request->adresse,
            'ice' => $request->ice, 
        ]);
       ///  dd($request->all()); // ✅ test if the request is received
        return redirect()->route('clients.index')->with('success', 'Client created successfully!');
    
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

        $client = Client::findOrFail($id);
        
        $client->update([
            'name' => $request->name,
            'adresse' => $request->adresse,
            'email' => $request->email,
            'tel' => $request->tel,
            'ice' => $request->ice,
        ]);
       
        return redirect()->route('clients.index')->with('success', 'Client mis à jour avec succès!');
    }
     public function show( string $id)
    {
         $client = Client::findOrFail($id);
        return view('clients.show', compact('client'));
         
    }
    public function edit(string $id)
    {
        $client = Client::findOrFail($id);
        return view('clients.edit', compact('client'));
    }

   

     /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $client = Client::findOrFail($id);
        $client->delete();

        return redirect()->route('clients.index')->with('success', 'Client supprimé avec succès!');
    }

     public function import(Request $request)
    {
        $request->validate([
            'file' => 'required|file|mimes:csv,txt|max:5120',
        ]);

        try {
            DB::transaction(function () use ($request) {
                Excel::import(new ClientsImport, $request->file('file'));
            });
        } catch (InvalidArgumentException $exception) {
            return redirect()->back()
                ->withInput()
                ->withErrors(['file' => $exception->getMessage()]);
        }

        return redirect()->route('clients.index')
            ->with('success', 'Clients importés avec succès.');
    }
}
