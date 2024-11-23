import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotespedia/constants/colors.dart';
import 'package:quotespedia/models/quotes_model.dart';
import 'package:quotespedia/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  List<QuotesPedia> _quotes = []; // Stores quotes as they are fetched
  bool _isLoading = false; // To prevent multiple API calls at the same time

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _fetchNewQuote(); // Fetch the first quote
  }

  Future<void> _fetchNewQuote() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Fetch a random category (optional)
      const categories = ["happiness", "life", "love", "success", "funny","failure"];
      final randomCategory = categories[Random().nextInt(categories.length)];

      // Fetch quotes from the API
      final fetchedQuotes = await QuoteService().fetchQuotes(randomCategory);

      // Add the first quote to the list
      if (fetchedQuotes.isNotEmpty) {
        setState(() {
          _quotes.add(fetchedQuotes[0]); // Add only one quote for simplicity
        });
      }
    } catch (e) {
      debugPrint("Error fetching quote: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  Widget _buildSkeleton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Skeleton for quote text
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12)
            ), // Light grey background for skeleton
          ),
        ),
       const SizedBox(height: 20),
        // Skeleton for author name
        Container(
          width: 150,
          height: 16,
          color: Colors.grey[300], // Light grey background for skeleton
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PediaColors.backgroundColor,
      body: _quotes.isEmpty && _isLoading
          ?  Center(child: _buildSkeleton())
          : PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          if (index == _quotes.length - 1 && !_isLoading) {
            // Fetch a new quote when reaching the last one
            _fetchNewQuote();
          }
        },
        itemCount: 50,
        itemBuilder: (context, index) {
          final quote = _quotes[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            color: Colors.blueAccent,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "\"${quote.quote}\"",
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Text(
                    "- ${quote.authorName}",
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
